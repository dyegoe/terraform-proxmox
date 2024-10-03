resource "random_password" "this" {
  length  = 8
  special = false
}

resource "random_password" "salt" {
  length  = 8
  special = false
}
resource "htpasswd_password" "this" {
  password = random_password.this.result
  salt     = random_password.salt.result
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/cloud-config.yaml")
  vars = {
    user           = var.user
    groups         = join(",", var.groups)
    ssh_public_key = var.ssh_public_key
    hostname       = var.name
    domain         = var.domain
    root_password  = htpasswd_password.this.sha512
  }
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node_name

  source_raw {
    data      = data.template_file.user_data.rendered
    file_name = "${var.name}.cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "this" {
  name            = var.name
  description     = "Created by Terraform"
  tags            = concat(var.tags, ["terraform"])
  node_name       = var.node_name
  stop_on_destroy = true

  agent {
    enabled = true
    timeout = "5m"
  }

  memory {
    dedicated = var.memory
  }

  cpu {
    cores = var.cpu
    type  = "x86-64-v2-AES"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = var.disk_image_id
    interface    = "scsi0"
    size         = var.disk_size
  }

  dynamic "disk" {
    for_each = { for i, v in var.additional_disks : i => v }
    content {
      datastore_id = "local-lvm"
      interface    = "scsi${disk.key + 1}"
      size         = disk.value.size
      file_format  = "raw"
    }
  }

  initialization {
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id

    ip_config {
      dynamic "ipv4" {
        for_each = var.network != null ? [1] : []
        content {
          address = var.network.ip_address
          gateway = var.network.gateway
        }
      }
      dynamic "ipv4" {
        for_each = var.network == null ? [1] : []
        content {
          address = "dhcp"
        }
      }
    }
  }

  network_device {
    bridge = "vmbr0"
  }
}

data "cloudflare_zone" "this" {
  count = var.dns_record ? 1 : 0
  name  = var.cloudflare_zone
}

resource "cloudflare_record" "this" {
  count      = var.dns_record ? 1 : 0
  zone_id    = data.cloudflare_zone.this[0].id
  name       = "${var.name}.${var.domain}."
  type       = "A"
  value      = element(flatten(element(proxmox_virtual_environment_vm.this.ipv4_addresses, 1)), 0)
  ttl        = 60
  depends_on = [proxmox_virtual_environment_vm.this]
}
