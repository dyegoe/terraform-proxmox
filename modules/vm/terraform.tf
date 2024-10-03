terraform {
  required_version = ">= 1.3.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.49.0"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 2.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
    htpasswd = {
      source  = "loafoe/htpasswd"
      version = ">= 1.0.4"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.39.0"
    }
  }
}
