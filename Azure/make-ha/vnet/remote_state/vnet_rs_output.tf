output "storage_account_name" {
  value = azurerm_storage_account.sa-rs.name
}

output "storage_account" {
  value = azurerm_storage_account.sa-rs
}

output "storage_rg_name" {
  value = azurerm_resource_group.sa-rs-rg.name
}

output "storage_group" {
  value = azurerm_resource_group.sa-rs-rg
}
