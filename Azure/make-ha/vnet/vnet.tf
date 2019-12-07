module "vnet" {
  source = "../modules/base-vnet"

  location = var.location
  project = var.project
  subnet1_address_prefix = var.subnet1_address_prefix
  subnet2_address_prefix = var.subnet2_address_prefix
  vnet_address_space = var.vnet_address_space
  local_dns_servers = var.local_dns_servers
}
