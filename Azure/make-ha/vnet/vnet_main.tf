module "vnet" {
  source             = "../modules/base-vnet"
  location           = var.location
  project            = var.project
  vnet_address_space = var.vnet_address_space
}

module "pub_subnet" {
  source             = "../modules/base-subnet"
  resources_count    = var.resources_count
  location           = var.location
  vnet_name          = module.vnet.vnet_name
  vnet_rg_name       = module.vnet.vnet_rg_name
  is_public          = true
  vnet_address_space = module.vnet.vnet_address
  project            = var.project
}

module "priv_subnet" {
  source             = "../modules/base-subnet"
  resources_count     = var.resources_count
  location           = var.location
  vnet_name          = module.vnet.vnet_name
  vnet_rg_name       = module.vnet.vnet_rg_name
  is_public          = false
  vnet_address_space = module.vnet.vnet_address
  project            = var.project
}
