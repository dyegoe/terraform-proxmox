output "ipv4_addresses" {
  value = {
    for name, instance in module.vms : name => join(", ", flatten(instance.ipv4_addresses))
  }
  description = "The IP addresses of the VMs."
}

output "root_passwords" {
  value = {
    for name, instance in module.vms : name => instance.root_password
  }
  description = "A random password for the user root."
  sensitive   = true
}
