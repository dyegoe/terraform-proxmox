# Terraform Proxmox module / images

Terraform module to import images into Proxmox.

## Images

- Ubuntu 22.04 cloud image
- Ubuntu 23.10 cloud image

<!-- markdownlint-disable MD033 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.34.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.34.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_file.ubuntu22](https://registry.terraform.io/providers/bpg/proxmox/0.34.0/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_file.ubuntu23_10](https://registry.terraform.io/providers/bpg/proxmox/0.34.0/docs/resources/virtual_environment_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Proxmox node name | `string` | `"pve"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ubuntu22"></a> [ubuntu22](#output\_ubuntu22) | Ubuntu 22.04 cloud image |
| <a name="output_ubuntu23_10"></a> [ubuntu23\_10](#output\_ubuntu23\_10) | Ubuntu 23.10 cloud image |
<!-- END_TF_DOCS -->
<!-- markdownlint-enable MD033 -->
