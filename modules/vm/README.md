# Terraform Proxmox module / VM

Terraform module to create Proxmox VMs.

<!-- markdownlint-disable MD033 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.17.0 |
| <a name="requirement_htpasswd"></a> [htpasswd](#requirement\_htpasswd) | 1.0.4 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.34.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 4.17.0 |
| <a name="provider_htpasswd"></a> [htpasswd](#provider\_htpasswd) | 1.0.4 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.34.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.this](https://registry.terraform.io/providers/cloudflare/cloudflare/4.17.0/docs/resources/record) | resource |
| [htpasswd_password.this](https://registry.terraform.io/providers/loafoe/htpasswd/1.0.4/docs/resources/password) | resource |
| [proxmox_virtual_environment_file.cloud_config](https://registry.terraform.io/providers/bpg/proxmox/0.34.0/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_vm.this](https://registry.terraform.io/providers/bpg/proxmox/0.34.0/docs/resources/virtual_environment_vm) | resource |
| [random_password.salt](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |
| [cloudflare_zone.this](https://registry.terraform.io/providers/cloudflare/cloudflare/4.17.0/docs/data-sources/zone) | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_zone"></a> [cloudflare\_zone](#input\_cloudflare\_zone) | The Cloudflare zone to create DNS records in. | `string` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of virtual CPUs to allocate on the VM. | `number` | `1` | no |
| <a name="input_disk_image_id"></a> [disk\_image\_id](#input\_disk\_image\_id) | The disk image to use for the VMs. Must be a valid disk image ID. Download from URL using the proxmox UI. | `string` | `"local:iso/jammy-server-cloudimg-amd64.img"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | The size of the disk to allocate to the VM in GB. | `number` | `8` | no |
| <a name="input_dns_record"></a> [dns\_record](#input\_dns\_record) | Whether to create a Cloudflare DNS record for the VM. | `bool` | `false` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The domain to use for the VM. | `string` | n/a | yes |
| <a name="input_groups"></a> [groups](#input\_groups) | The groups to add the user to. | `list(string)` | <pre>[<br>  "users",<br>  "admin"<br>]</pre> | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory to allocate on the VM in MB. | `number` | `0.5` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the VM. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | Network configuration for the VM. | <pre>object({<br>    ip_address = string<br>    gateway    = string<br>  })</pre> | `null` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Proxmox node name. | `string` | `"pve"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The public key to add to the user's authorized\_keys file. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to the VM. | `list(string)` | `[]` | no |
| <a name="input_user"></a> [user](#input\_user) | The user to create on the VM. | `string` | `"ubuntu"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4_addresses"></a> [ipv4\_addresses](#output\_ipv4\_addresses) | The IP addresses of the VM. |
| <a name="output_root_password"></a> [root\_password](#output\_root\_password) | A random password for the user root. |
<!-- END_TF_DOCS -->
<!-- markdownlint-enable MD033 -->
