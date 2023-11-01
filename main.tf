module "vms" {
  for_each        = var.vms
  source          = "./modules/vm"
  cloudflare_zone = var.cloudflare_zone
  domain          = var.domain
  node_name       = var.node_name
  name            = each.key
  user            = lookup(each.value, "user", null) != null ? each.value.user : var.user
  groups          = lookup(each.value, "groups", null) != null ? each.value.groups : var.groups
  ssh_public_key  = lookup(each.value, "ssh_public_key", null) != null ? each.value.ssh_public_key : var.ssh_public_key
  disk_image_id   = lookup(each.value, "disk_image_id", null) != null ? each.value.disk_image_id : var.disk_image_id
  memory          = lookup(each.value, "memory", null) != null ? each.value.memory : var.memory
  cpu             = lookup(each.value, "cpu", null) != null ? each.value.cpu : var.cpu
  disk_size       = lookup(each.value, "disk_size", null) != null ? each.value.disk_size : var.disk_size
  network = lookup(each.value, "network", null) != null ? {
    ip_address = each.value.network.ip_address
    gateway    = each.value.network.gateway
  } : null
  dns_record = lookup(each.value, "dns_record", null) != null ? each.value.dns_record : var.dns_record
  tags       = concat(lookup(each.value, "tags", []), var.tags)
}
