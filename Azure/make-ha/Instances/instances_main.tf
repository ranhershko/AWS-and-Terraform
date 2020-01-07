module "web_instance" {
  source = "../modules/base-instance"

  location                      = var.location
  project                       = var.project
  resources_count               = var.resources_count

  vnet_address_space            = var.vnet_address_space
  subnet_ids                    = data.terraform_remote_state.vnet.outputs.pub_subnet_ids
  is_public                     = true
  availability_set_domain_count = var.availability_set_domain_count

  stor_account_tier             = var.stor_account_tier
  stor_account_repl_type        = var.stor_account_repl_type

  os_type                       = var.os_type
  vm_size                       = var.vm_size
  managed_disk_type             = var.managed_disk_type
  packer_rg                     = var.packer_rg
  admin_username                = var.admin_username
}

module "db_instances" {
  source = "../modules/base-instance"

  location                      = var.location
  project                       = var.project
  resources_count               = var.resources_count

  vnet_address_space            = var.vnet_address_space
  subnet_ids                    = data.terraform_remote_state.vnet.outputs.priv_subnet_ids
  is_public                     = false
  availability_set_domain_count = var.availability_set_domain_count

  stor_account_tier             = var.stor_account_tier
  stor_account_repl_type        = var.stor_account_repl_type

  os_type                       = var.os_type
  vm_size                       = var.vm_size
  managed_disk_type             = var.managed_disk_type
  packer_rg                     = var.packer_rg
  admin_username                = var.admin_username
}
