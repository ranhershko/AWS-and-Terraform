resource "random_integer" "sa-rs-num" {
  min = 1
  max = 999
}

resource "azurerm_resource_group" "sa-rs-rg" {
  name     = "${var.project["prefix_name"]}-sa-remotestat-rg"
  location = var.location
}

resource "azurerm_storage_account" "sa-rs" {
  name                     = "${lower(var.project["prefix_name"])}saremotestat${random_integer.sa-rs-num.result}"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.sa-rs-rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sa-rs-ct" {
  name                 = "remotestatct"
  storage_account_name = azurerm_storage_account.sa-rs.name
}

resource "local_file" "backend-config" {
  content  = "storage_account_name = \"${local.storage["stor_acct"]}\"\ncontainer_name = \"${local.storage["cont_name"]}\"\nkey = \"${local.storage["tera_key"]}\"\nsas_token = \"${local.storage["sas"]}\""
  filename = "../backend-config.txt"
}

locals {
  storage = {
    stor_acct = "${azurerm_storage_account.sa-rs.name}"
    cont_name = "${azurerm_storage_container.sa-rs-ct.name}"
    sas       = "${data.azurerm_storage_account_sas.state.sas}"
    tera_key  = "vnet-terraform.tfstate"
  }
}