data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    storage_account_name = regex("(?:storage_account_name = \"(?P<storage_account_name>[^\n\"]*))?", data.local_file.vnet_backend_config.content)["storage_account_name"]
    sas_token            = regex("(?:sas_token = \"(?P<sas_token>[^\n\"]*))?", data.local_file.vnet_backend_config.content)["sas_token"]
    container_name       = "remotestatct"
    key                  = "vnet-terraform.tfstate"
  }
}

data "local_file" "vnet_backend_config" {
  filename = "../vnet/backend-config.txt"
}
