provider "proxmox" {
  endpoint = "https://172.31.85.10:8006"
  username = var.proxmox_user
  password = var.proxmox_password
  insecure = true
}

module "example" {
  source = "../."

  node_name      = "pve"
  user           = "ubuntu"
  groups         = ["users", "admin"]
  ssh_public_key = var.ssh_public_key
  domain         = "example.local"

  vms = {
    master = {
      tags       = ["master", "kubernetes"]
      memory     = 2048
      cpu        = 2
      disk_size  = 8
      ip_address = "172.31.85.11/24"
      gateway    = "172.31.85.1"
    }
    node01 = {
      tags       = ["node01", "kubernetes"]
      memory     = 2048
      cpu        = 2
      disk_size  = 8
      ip_address = "172.31.85.12/24"
      gateway    = "172.31.85.1"
    }
    node02 = {
      tags       = ["node02", "kubernetes"]
      memory     = 2048
      cpu        = 2
      disk_size  = 8
      ip_address = "172.31.85.13/24" # if you omit ip_address, it will be assigned by dhcp. You can also omit gateway.
      gateway    = "172.31.85.1"     # if you specify an ip_address, you must specify a gateway.
    }
  }
}
