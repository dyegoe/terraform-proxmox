output "ubuntu2204" {
  value       = try(proxmox_virtual_environment_file.ubuntu2204[0].id, null)
  description = "Ubuntu 22.04 cloud image"
}

output "ubuntu2310" {
  value       = try(proxmox_virtual_environment_file.ubuntu2310[0].id, null)
  description = "Ubuntu 23.10 cloud image"
}
