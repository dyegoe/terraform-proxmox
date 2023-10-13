output "ipv4_addresses" {
  value       = module.example.ipv4_addresses
  description = "The IP addresses of the instances."
}

output "root_passwords" {
  value       = module.example.root_passwords
  description = "Root passwords of the created VMs"
  sensitive   = true
}
