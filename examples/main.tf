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

  cloudflare_zone = "nodes.ee"
  domain          = "example.nodes.ee"
  node_name       = "pve"
  user            = "ubuntu"
  groups          = ["users", "admin"]
  ssh_public_key  = var.ssh_public_key
  disk_image_id   = "local:iso/jammy-server-cloudimg-amd64.img"
  memory          = 4096
  cpu             = 2
  disk_size       = 8
  dns_record      = true
  tags            = ["kubernetes"]

  vms = {
    master = {
      memory = 2048
      network = {
        ip_address = "172.31.85.30/24" # if you omit ip_address, it will be assigned by dhcp. You can also omit gateway.
        gateway    = "172.31.85.1"     # if you specify an ip_address, you must specify a gateway.
      }
      tags = ["master"]
    }
    node1 = {
      network = {
        ip_address = "172.31.85.31/24"
        gateway    = "172.31.85.1"
      }
      tags = ["node1"]
    }
    node2 = {
      network = {
        ip_address = "172.31.85.32/24"
        gateway    = "172.31.85.1"
      }
      tags = ["node2"]
    }
    node3 = {
      network = {
        ip_address = "172.31.85.33/24"
        gateway    = "172.31.85.1"
      }
      tags = ["node3"]
    }
    node4 = {
      tags = ["node4"]
    }
  }
}
