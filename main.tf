module "vms" {
  for_each       = var.vms
  source         = "./modules/vm"
  node_name      = var.node_name
  user           = var.user
  groups         = var.groups
  ssh_public_key = var.ssh_public_key
  domain         = var.domain
  disk_image_id  = var.disk_image_id
  name           = each.key
  memory         = each.value.memory
  cpu            = each.value.cpu
  disk_size      = each.value.disk_size
  network = lookup(each.value, "ip_address", null) != null ? {
    ip_address = each.value.ip_address
    gateway    = each.value.gateway
  } : null
  tags = each.value.tags
}
