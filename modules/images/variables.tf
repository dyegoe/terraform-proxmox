variable "node_name" {
  type        = string
  default     = "pve"
  description = "Proxmox node name"
}

variable "enable_ubuntu2204" {
  type        = bool
  description = "Enable Ubuntu 22.04"
}

variable "enable_ubuntu2310" {
  type        = bool
  description = "Enable Ubuntu 23.10"
}
