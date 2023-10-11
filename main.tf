data "template_file" "user_data" {
  for_each = var.instances

  template = file("${path.module}/templates/cloud-config.yaml")
  vars = {
    user           = var.user
    groups         = join(",", var.groups)
    ssh_public_key = var.ssh_public_key
    hostname       = each.key
    domain         = var.domain
  }
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  for_each = var.instances

  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node_name

  source_raw {
    data      = data.template_file.user_data[each.key].rendered
    file_name = "${each.key}.cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "this" {
  for_each = var.instances

  name        = each.key
  description = "Created by Terraform"
  tags        = concat(each.value.tags, ["terraform"])
  node_name   = var.node_name

  agent {
    enabled = true
  }

  memory {
    dedicated = each.value.memory
  }

  cpu {
    cores = each.value.vcpu
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = var.disk_image_id
    interface    = "scsi0"
    size         = each.value.disk_size
  }

  initialization {
    user_data_file_id = proxmox_virtual_environment_file.cloud_config[each.key].id

    ip_config {
      dynamic "ipv4" {
        for_each = each.value.ip_address != null ? [1] : []
        content {
          address = each.value.ip_address
          gateway = each.value.gateway
        }
      }
      dynamic "ipv4" {
        for_each = each.value.ip_address == null ? [1] : []
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
