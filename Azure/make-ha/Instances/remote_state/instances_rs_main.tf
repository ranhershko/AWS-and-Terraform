resource "local_file" "backend-config" {
  content  = "storage_account_name = \"${local.storage["stor_acct"]}\"\ncontainer_name = \"${local.storage["cont_name"]}\"\nkey = \"${local.storage["tera_rs_key"]}\"\nsas_token = \"${local.storage["sas_token"]}\""
  filename = "../backend-config.txt"
}

locals {
  storage = {
    stor_acct   = regex("(?:storage_account_name = \"(?P<stor_acct>[^\n\"]*))?", data.local_file.vnet_backend_config.content)["stor_acct"]
    cont_name   = "remotestatct"
    sas_token   = data.azurerm_storage_account_sas.state.sas
    tera_rs_key = "instances-terraform.tfstate"
  }
}

