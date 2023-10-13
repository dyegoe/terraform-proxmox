output "ipv4_addresses" {
  value = {
    for name, instance in module.vms : name => join(", ", flatten(instance.ipv4_addresses))
  }
  description = "The IP addresses of the VMs."
}
