variable "proxmox_user" {
  type        = string
  default     = "root@pam"
  description = "Proxmox user"
}

variable "proxmox_password" {
  type        = string
  default     = "password"
  description = "Proxmox password"
}

variable "ssh_public_key" {
  type        = string
  description = "The public key to add to the user's authorized_keys file."
}
