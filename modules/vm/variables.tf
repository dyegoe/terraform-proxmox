variable "cloudflare_zone" {
  type        = string
  description = "The Cloudflare zone to create DNS records in."
  validation {
    condition     = can(regex("^[a-z0-9-]+(\\.[a-z0-9-]+)*$", var.cloudflare_zone))
    error_message = "Domain must be a valid domain name."
  }
}

variable "domain" {
  type        = string
  description = "The domain to use for the VM."
  validation {
    condition     = can(regex("^[a-z0-9-]+(\\.[a-z0-9-]+)*$", var.domain))
    error_message = "Domain must be a valid domain name."
  }
}

variable "node_name" {
  type        = string
  default     = "pve"
  description = "Proxmox node name."
}

variable "name" {
  type        = string
  description = "The name of the VM."
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name))
    error_message = "Name must be a valid hostname."
  }
  validation {
    condition     = length(var.name) <= 15
    error_message = "Name must be 15 characters or less."
  }
}

variable "user" {
  type        = string
  default     = "ubuntu"
  description = "The user to create on the VM."
}

variable "groups" {
  type        = list(string)
  default     = ["users", "admin"]
  description = "The groups to add the user to."
}

variable "ssh_public_key" {
  type        = string
  description = "The public key to add to the user's authorized_keys file."
}

variable "disk_image_id" {
  type        = string
  default     = "local:iso/jammy-server-cloudimg-amd64.img"
  description = "The disk image to use for the VMs. Must be a valid disk image ID. Download from URL using the proxmox UI."
}

variable "memory" {
  type        = number
  default     = 0.5
  description = "The amount of memory to allocate on the VM in MB."
}

variable "cpu" {
  type        = number
  default     = 1
  description = "The number of virtual CPUs to allocate on the VM."
}

variable "disk_size" {
  type        = number
  default     = 8
  description = "The size of the disk to allocate to the VM in GB."
}

variable "network" {
  type = object({
    ip_address = string
    gateway    = string
  })
  default     = null
  description = "Network configuration for the VM."
  validation {
    condition     = var.network != null ? (var.network.ip_address != null ? var.network.gateway != null : true) : true
    error_message = "If ip_address is provided, gateway must also be provided."
  }
  validation {
    condition     = var.network != null ? (var.network.ip_address != null ? can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+/[0-9]+$", var.network.ip_address)) : true) : true
    error_message = "If ip_address is provided, it must have a CIDR suffix."
  }
}

variable "dns_record" {
  type        = bool
  default     = false
  description = "Whether to create a Cloudflare DNS record for the VM."
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "Tags to add to the VM."
}
