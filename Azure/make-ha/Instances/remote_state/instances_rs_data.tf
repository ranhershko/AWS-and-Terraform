data "azurerm_storage_account_sas" "state" {
  connection_string = data.azurerm_storage_account.vnet_rs_state.primary_connection_string
  https_only        = true

  resource_types {
    container = true
    object    = true
    service   = true
  }

  services {
    blob  = true
    file  = false
    queue = false
    table = false
  }

  start  = timestamp()
  expiry = timeadd(timestamp(), "8760h")
  permissions {
    add     = true
    create  = true
    delete  = true
    list    = true
    process = false
    read    = true
    update  = false
    write   = true
  }
}

data "azurerm_storage_account" "vnet_rs_state" {
  name                = regex("(?:storage_account_name = \"(?P<storage_account_name>[^\n\"]*))?", data.local_file.vnet_backend_config.content)["storage_account_name"]
  resource_group_name = "${var.project["prefix_name"]}-sa-remotestat-rg"
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    storage_account_name = regex("(?:storage_account_name = \"(?P<storage_account_name>[^\n\"]*))?", data.local_file.vnet_backend_config.content)["storage_account_name"]
    sas_token            = data.azurerm_storage_account_sas.state.sas
    container_name       = "remotestatct"
    key                  = "vnet-terraform.tfstate"
  }
}

data "local_file" "vnet_backend_config" {
  filename = "../../vnet/backend-config.txt"
}
