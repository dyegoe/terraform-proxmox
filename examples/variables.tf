variable "proxmox_user" {
  type        = string
  default     = "root@pam"
  description = "Proxmox user"
}

variable "proxmox_password" {
  type        = string
  description = "Proxmox password"
}

variable "ssh_public_key" {
  type        = string
  description = "The public key to add to the user's authorized_keys file."
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token"
}
