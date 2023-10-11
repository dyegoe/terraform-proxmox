output "ip_addresses" {
  value = {
    for name, instance in proxmox_virtual_environment_vm.this : name => join(", ", flatten(instance.ipv4_addresses))
  }
  description = "The IP addresses of the instances."
}
