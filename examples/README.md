# Terraform Proxmox module - examples

Examples of how to use the Proxmox module.

## Usage

Export the following environment variables:

```bash
export TF_VAR_ssh_public_key="ssh-ed25519 AAAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export TF_VAR_proxmox_password="xxxxxxxxxxxx"
export TF_VAR_cloudflare_api_token="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

Then run the following commands:

```bash
make tfapply
```

<!-- markdownlint-disable MD033 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.17.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.34.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example"></a> [example](#module\_example) | ../. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | Cloudflare API token | `string` | n/a | yes |
| <a name="input_proxmox_password"></a> [proxmox\_password](#input\_proxmox\_password) | Proxmox password | `string` | n/a | yes |
| <a name="input_proxmox_user"></a> [proxmox\_user](#input\_proxmox\_user) | Proxmox user | `string` | `"root@pam"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The public key to add to the user's authorized\_keys file. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4_addresses"></a> [ipv4\_addresses](#output\_ipv4\_addresses) | The IP addresses of the instances. |
| <a name="output_root_passwords"></a> [root\_passwords](#output\_root\_passwords) | Root passwords of the created VMs |
<!-- END_TF_DOCS -->
<!-- markdownlint-enable MD033 -->
