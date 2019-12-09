module "vnet" {
  source = "../modules/base-vnet"

  location           = var.location
  project            = var.project
  vnet_address_space = var.vnet_address_space
  local_dns_servers  = [cidrhost(var.vnet_address_space[0], 4), cidrhost(var.vnet_address_space[0], 5)]
}

module "pub_subnet" {
  sub_count          = 2
  source             = "../modules/base-subnet"
  location           = module.vnet.location
  vnet_name          = module.vnet.vnet_name
  vnet_rg_name       = module.vnet.vnet_rg_name
  is_public          = true
  vnet_address_space = module.vnet.vnet_address
  project            = module.vnet.project
}