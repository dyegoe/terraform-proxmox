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
  description = "The domain to use for the VMs."
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

variable "user" {
  type        = string
  default     = "ubuntu"
  description = "Global user to create on the VMs. Can be overridden per VM."
}

variable "groups" {
  type        = list(string)
  default     = ["users", "admin"]
  description = "Global groups to add the user to. Can be overridden per VM."
}

variable "ssh_public_key" {
  type        = string
  description = "Global public key to add to the user's authorized_keys file. Can be overridden per VM."
}

variable "disk_image_id" {
  type        = string
  default     = "local:iso/jammy-server-cloudimg-amd64.img"
  description = "Global disk image to use for the VMs. Can be overridden per VM. Must be a valid disk image ID. Download from URL using the proxmox UI."
}

variable "memory" {
  type        = number
  default     = 512
  description = "Global amount of memory to allocate to each VM in MB. Can be overridden per VM."
}

variable "cpu" {
  type        = number
  default     = 1
  description = "Global number of virtual CPUs to allocate to each VM. Can be overridden per VM."
}

variable "disk_size" {
  type        = number
  default     = 3
  description = "Global size of the root disk to allocate to each VM in GB. Can be overridden per VM."
}

variable "additional_disks" {
  type = list(object({
    size = number
  }))
  default     = []
  description = "Global additional disks to add to the VMs. Each disk must have a size in GB. Can be overridden per VM."
}

variable "dns_record" {
  type        = bool
  default     = false
  description = "Whether to create a Cloudflare DNS record for the VMs. Can be overridden per VM."
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "Tags to add to the VMs. It is merged with the tags provided per VM."
}

variable "vms" {
  type = map(object({
    user           = optional(string)
    groups         = optional(list(string))
    ssh_public_key = optional(string)
    disk_image_id  = optional(string)
    memory         = optional(number)
    cpu            = optional(number)
    disk_size      = optional(number)
    additional_disks = optional(list(object({
      size = number
    })))
    network = optional(object({
      ip_address = string
      gateway    = string
    }))
    dns_record = optional(bool)
    tags       = optional(list(string))
  }))
  default     = {}
  description = <<EOT
A map of VM names to VM configurations.
memory in MB.
disk_size in GB.
additional_disks is a list of objects with a size in GB.
EOT
  validation {
    condition     = length(keys(var.vms)) > 0
    error_message = "At least one VM must be defined."
  }
  validation {
    condition     = length(keys(var.vms)) == length(distinct(keys(var.vms)))
    error_message = "VM name must be unique."
  }
  validation {
    condition     = alltrue([for name, vm in var.vms : can(regex("^[a-z0-9-]+$", name))])
    error_message = "VM name must be lowercase alphanumeric with dashes."
  }
  validation {
    condition     = alltrue([for name, vm in var.vms : can(regex("^[a-z0-9-]{1,15}$", name))])
    error_message = "VM name must be 15 characters or less."
  }
}
