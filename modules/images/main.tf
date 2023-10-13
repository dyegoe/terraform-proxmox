resource "proxmox_virtual_environment_file" "ubuntu22" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.node_name

  source_file {
    path = "https://cloud-images.ubuntu.com/jammy/20231012/jammy-server-cloudimg-amd64.img"
  }
}

resource "proxmox_virtual_environment_file" "ubuntu23_10" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.node_name

  source_file {
    path = "https://cloud-images.ubuntu.com/mantic/20231011/mantic-server-cloudimg-amd64.img"
  }
}
