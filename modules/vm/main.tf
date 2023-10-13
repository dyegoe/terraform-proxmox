data "template_file" "user_data" {
  template = file("${path.module}/templates/cloud-config.yaml")
  vars = {
    user           = var.user
    groups         = join(",", var.groups)
    ssh_public_key = var.ssh_public_key
    hostname       = var.name
    domain         = var.domain
  }
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node

  source_raw {
    data      = data.template_file.user_data.rendered
    file_name = "${var.name}.cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "this" {
  name        = var.name
  description = "Created by Terraform"
  tags        = concat(var.tags, ["terraform"])
  node_name   = var.node

  agent {
    enabled = true
    timeout = "5m"
  }

  memory {
    dedicated = var.memory
  }

  cpu {
    cores = var.cpu
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = var.disk_image_id
    interface    = "scsi0"
    size         = var.disk_size
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
