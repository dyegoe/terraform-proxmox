variable "node_name" {
  type        = string
  default     = "pve"
  description = "Proxmox node name"
}

variable "user" {
  type        = string
  default     = "ubuntu"
  description = "The user to create on the instances."
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

variable "domain" {
  type        = string
  default     = "example.com"
  description = "The domain to use for the instances."
  validation {
    condition     = can(regex("^[a-z0-9-]+(\\.[a-z0-9-]+)*$", var.domain))
    error_message = "Domain must be a valid domain name."
  }
}

variable "disk_image_id" {
  type        = string
  default     = "local:iso/jammy-server-cloudimg-amd64.img"
  description = "The disk image to use for the instances. Must be a valid disk image ID. Download from URL using the proxmox UI."
}

variable "instances" {
  type = map(object({
    tags       = list(string)
    memory     = number
    vcpu       = number
    disk_size  = number
    ip_address = optional(string, null)
    gateway    = optional(string, null)
  }))
  default     = {}
  description = <<EOT
A map of instance names to instance configurations.
memory in megabytes.
disk_size in GB.
ip_address is optional. If not provided, DHCP will be used. If provided, must have a CIDR suffix.
EOT

  validation {
    condition     = length(keys(var.instances)) > 0
    error_message = "At least one instance must be defined."
  }

  validation {
    condition     = length(keys(var.instances)) == length(distinct(keys(var.instances)))
    error_message = "Instance names must be unique."
  }

  validation {
    condition     = alltrue([for name, instance in var.instances : can(regex("^[a-z0-9-]+$", name))])
    error_message = "Instance names must be lowercase alphanumeric with dashes."
  }

  validation {
    condition     = alltrue([for name, instance in var.instances : can(regex("^[a-z0-9-]{1,15}$", name))])
    error_message = "Instance names must be 15 characters or less."
  }

  validation {
    condition     = alltrue([for name, instance in var.instances : instance.ip_address != null ? instance.gateway != null : true])
    error_message = "If ip_address is provided, gateway must also be provided."
  }

  validation {
    condition     = alltrue([for name, instance in var.instances : instance.ip_address != null ? can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+/[0-9]+$", instance.ip_address)) : true])
    error_message = "If ip_address is provided, it must have a CIDR suffix."
  }
}