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

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.34.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_file.cloud_config](https://registry.terraform.io/providers/bpg/proxmox/0.34.0/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_vm.this](https://registry.terraform.io/providers/bpg/proxmox/0.34.0/docs/resources/virtual_environment_vm) | resource |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_image_id"></a> [disk\_image\_id](#input\_disk\_image\_id) | The disk image to use for the instances. Must be a valid disk image ID. Download from URL using the proxmox UI. | `string` | `"local:iso/jammy-server-cloudimg-amd64.img"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The domain to use for the instances. | `string` | `"example.com"` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | The groups to add the user to. | `list(string)` | <pre>[<br>  "users",<br>  "admin"<br>]</pre> | no |
| <a name="input_instances"></a> [instances](#input\_instances) | A map of instance names to instance configurations.<br>memory in megabytes.<br>disk\_size in GB.<br>ip\_address is optional. If not provided, DHCP will be used. If provided, must have a CIDR suffix. | <pre>map(object({<br>    tags       = list(string)<br>    memory     = number<br>    vcpu       = number<br>    disk_size  = number<br>    ip_address = optional(string, null)<br>    gateway    = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Proxmox node name | `string` | `"pve"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The public key to add to the user's authorized\_keys file. | `string` | n/a | yes |
| <a name="input_user"></a> [user](#input\_user) | The user to create on the instances. | `string` | `"ubuntu"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_addresses"></a> [ip\_addresses](#output\_ip\_addresses) | The IP addresses of the instances. |
<!-- END_TF_DOCS -->
<!-- markdownlint-enable MD033 -->
