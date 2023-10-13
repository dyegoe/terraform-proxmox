resource "proxmox_virtual_environment_file" "ubuntu22" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.node_name

  source_file {
    path = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  }
}
