output "ipv4_addresses" {
  value       = flatten(proxmox_virtual_environment_vm.this.ipv4_addresses)
  description = "The IP addresses of the VM."
}

output "root_password" {
  value       = random_password.this.result
  description = "A random password for the user root."
  sensitive   = true
}
