provider "proxmox" {
  endpoint = "https://172.31.85.10:8006"
  username = var.proxmox_user
  password = var.proxmox_password
  insecure = true
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

module "example" {
  source = "../."

  # These are global variables that will be used for all VMs.
  cloudflare_zone = "nodes.ee"
  domain          = "example.nodes.ee"
  node_name       = "pve"
  # These are the global default values for the VMs. They can be overridden per VM.
  user             = "ubuntu"
  groups           = ["users", "admin"]
  ssh_public_key   = var.ssh_public_key
  disk_image_id    = "local:iso/jammy-server-cloudimg-amd64.img"
  memory           = 8192
  cpu              = 2
  disk_size        = 10
  additional_disks = [{ size = 5 }]
  dns_record       = false
  tags             = ["kubernetes"] # But tags are always appended to the tags specified per VM.

  vms = {
    master = {
      memory = 3072
      network = {                      # if you omit network, ip address will be assigned by dhcp.
        ip_address = "172.31.85.30/24" # if you specify an ip_address, you must specify a gateway.
        gateway    = "172.31.85.1"
      }
      tags = ["master"]
    }
    node1 = {
      network = { ip_address = "172.31.85.31/24", gateway = "172.31.85.1" }
      tags    = ["node1"]
    }
    node2 = {
      network = { ip_address = "172.31.85.32/24", gateway = "172.31.85.1" }
      tags    = ["node2"]
    }
    node3 = {
      network = { ip_address = "172.31.85.33/24", gateway = "172.31.85.1" }
      tags    = ["node3"]
    }
  }
}
