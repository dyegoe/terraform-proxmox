output "ipv4_addresses" {
  value       = proxmox_virtual_environment_vm.this.ipv4_addresses
  description = "The IP addresses of the VM."
}
