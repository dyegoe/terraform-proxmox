resource "proxmox_virtual_environment_file" "ubuntu2204" {
  count        = var.enable_ubuntu2204 ? 1 : 0
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.node_name

  source_file {
    path = "https://cloud-images.ubuntu.com/jammy/20231018/jammy-server-cloudimg-amd64.img"
  }
}

resource "proxmox_virtual_environment_file" "ubuntu2310" {
  count        = var.enable_ubuntu2310 ? 1 : 0
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.node_name

  source_file {
    path = "https://cloud-images.ubuntu.com/mantic/20231014/mantic-server-cloudimg-amd64.img"
  }
}
