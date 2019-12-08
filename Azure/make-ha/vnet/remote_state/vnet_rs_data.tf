data "azurerm_storage_account_sas" "state" {
  connection_string = azurerm_storage_account.sa-rs.primary_connection_string
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

