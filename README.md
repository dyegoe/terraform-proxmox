# Terraform Proxmox module

Terraform module to create Proxmox infrastructure.

## Limitations

- Only supports a single (proxmox) node for all VMs

## Usage

For usage examples see the [examples](./examples) directory.

<!-- markdownlint-disable MD033 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 4.38.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.49.0 |

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
| <a name="input_additional_disks"></a> [additional\_disks](#input\_additional\_disks) | Global additional disks to add to the VMs. Each disk must have a size in GB. Can be overridden per VM. | <pre>list(object({<br>    size = number<br>  }))</pre> | `[]` | no |
| <a name="input_cloudflare_zone"></a> [cloudflare\_zone](#input\_cloudflare\_zone) | The Cloudflare zone to create DNS records in. | `string` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Global number of virtual CPUs to allocate to each VM. Can be overridden per VM. | `number` | `1` | no |
| <a name="input_disk_image_id"></a> [disk\_image\_id](#input\_disk\_image\_id) | Global disk image to use for the VMs. Can be overridden per VM. Must be a valid disk image ID. Download from URL using the proxmox UI. | `string` | `"local:iso/jammy-server-cloudimg-amd64.img"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Global size of the root disk to allocate to each VM in GB. Can be overridden per VM. | `number` | `3` | no |
| <a name="input_dns_record"></a> [dns\_record](#input\_dns\_record) | Whether to create a Cloudflare DNS record for the VMs. Can be overridden per VM. | `bool` | `false` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The domain to use for the VMs. | `string` | n/a | yes |
| <a name="input_groups"></a> [groups](#input\_groups) | Global groups to add the user to. Can be overridden per VM. | `list(string)` | <pre>[<br>  "users",<br>  "admin"<br>]</pre> | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Global amount of memory to allocate to each VM in MB. Can be overridden per VM. | `number` | `512` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Proxmox node name. | `string` | `"pve"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | Global public key to add to the user's authorized\_keys file. Can be overridden per VM. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to the VMs. It is merged with the tags provided per VM. | `list(string)` | `[]` | no |
| <a name="input_user"></a> [user](#input\_user) | Global user to create on the VMs. Can be overridden per VM. | `string` | `"ubuntu"` | no |
| <a name="input_vms"></a> [vms](#input\_vms) | A map of VM names to VM configurations.<br>memory in MB.<br>disk\_size in GB.<br>additional\_disks is a list of objects with a size in GB. | <pre>map(object({<br>    user           = optional(string)<br>    groups         = optional(list(string))<br>    ssh_public_key = optional(string)<br>    disk_image_id  = optional(string)<br>    memory         = optional(number)<br>    cpu            = optional(number)<br>    disk_size      = optional(number)<br>    additional_disks = optional(list(object({<br>      size = number<br>    })))<br>    network = optional(object({<br>      ip_address = string<br>      gateway    = string<br>    }))<br>    dns_record = optional(bool)<br>    tags       = optional(list(string))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4_addresses"></a> [ipv4\_addresses](#output\_ipv4\_addresses) | The IP addresses of the VMs. |
| <a name="output_root_passwords"></a> [root\_passwords](#output\_root\_passwords) | A random password for the user root. |
<!-- END_TF_DOCS -->
<!-- markdownlint-enable MD033 -->
