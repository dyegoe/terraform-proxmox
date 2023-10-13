# Terraform Proxmox module

Terraform module to create Proxmox infra

## Limitations

- Only supports a single (proxmox) node for all VMs
- It only launches VMs using Ubuntu 22.04

<!-- markdownlint-disable MD033 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.34.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vms"></a> [vms](#module\_vms) | ./modules/vm | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_image_id"></a> [disk\_image\_id](#input\_disk\_image\_id) | The disk image to use for the VMs. Must be a valid disk image ID. Download from URL using the proxmox UI. | `string` | `"local:iso/jammy-server-cloudimg-amd64.img"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The domain to use for the VMs. | `string` | `"example.com"` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | The groups to add the user to. | `list(string)` | <pre>[<br>  "users",<br>  "admin"<br>]</pre> | no |
| <a name="input_node"></a> [node](#input\_node) | Proxmox node name | `string` | `"pve"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The public key to add to the user's authorized\_keys file. | `string` | n/a | yes |
| <a name="input_user"></a> [user](#input\_user) | The user to create on the VMs. | `string` | `"ubuntu"` | no |
| <a name="input_vms"></a> [vms](#input\_vms) | A map of VM names to VM configurations.<br>memory in megabytes.<br>disk\_size in GB.<br>ip\_address is optional. If not provided, DHCP will be used. If provided, must have a CIDR suffix. | <pre>map(object({<br>    tags       = list(string)<br>    memory     = number<br>    cpu        = number<br>    disk_size  = number<br>    ip_address = optional(string, null)<br>    gateway    = optional(string, null)<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4_addresses"></a> [ipv4\_addresses](#output\_ipv4\_addresses) | The IP addresses of the VMs. |
<!-- END_TF_DOCS -->
<!-- markdownlint-enable MD033 -->
