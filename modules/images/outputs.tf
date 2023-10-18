output "ubuntu22" {
  value       = proxmox_virtual_environment_file.ubuntu22.id
  description = "Ubuntu 22.04 cloud image"
}

output "ubuntu2310" {
  value       = proxmox_virtual_environment_file.ubuntu2310.id
  description = "Ubuntu 23.10 cloud image"
}
