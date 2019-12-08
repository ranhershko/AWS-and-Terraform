output "storage_account_name" {
  value = azurerm_storage_account.sa-rs.name
}

output "storage_group_name" {
  value = azurerm_resource_group.sa-rs-rg.name
}
