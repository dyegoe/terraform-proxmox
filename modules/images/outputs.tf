output "ubuntu22" {
  value       = proxmox_virtual_environment_file.ubuntu22.id
  description = "Ubuntu 22.04 cloud image"
}

output "ubuntu23_10" {
  value       = proxmox_virtual_environment_file.ubuntu23_10.id
  description = "Ubuntu 23.10 cloud image"
}
