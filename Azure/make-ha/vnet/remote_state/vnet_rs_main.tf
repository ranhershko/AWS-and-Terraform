resource "azurerm_resource_group" "sa-rs-rg" {
  name     = "${var.project["prefix_name"]}-sa-remotestat-rg"
  location = var.location
  tags     = merge(local.common_tags, { "Name" = "${var.project["prefix_name"]}-remotestate-rg" })
}

resource "random_integer" "sa-rs-num" {
  min = 1
  max = 999
}

resource "azurerm_storage_account" "sa-rs" {
  name                     = "${lower(var.project["prefix_name"])}saremotestat${random_integer.sa-rs-num.result}"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.sa-rs-rg.name
  account_tier             = var.stor_account_tier
  account_replication_type = var.stor_account_repl_type
  tags                     = merge(local.common_tags, { "Name" = "${var.project["prefix_name"]}-remotestate-sa" })
}

resource "azurerm_storage_container" "sa-rs-ct" {
  name                 = "remotestatct"
  storage_account_name = azurerm_storage_account.sa-rs.name
}

resource "local_file" "backend-config" {
  content  = "storage_account_name = \"${local.storage["stor_acct"]}\"\ncontainer_name = \"${local.storage["cont_name"]}\"\nkey = \"${local.storage["tera_rs_key"]}\"\nsas_token = \"${local.storage["sas_token"]}\""
  filename = "../backend-config.txt"
}

locals {
  storage = {
    stor_acct   = azurerm_storage_account.sa-rs.name
    cont_name   = azurerm_storage_container.sa-rs-ct.name
    sas_token   = data.azurerm_storage_account_sas.state.sas
    tera_rs_key = "vnet-terraform.tfstate"
  }
}
