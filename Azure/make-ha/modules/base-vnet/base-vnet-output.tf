output "vnet_address" {
  value = azurerm_virtual_network.base_net.address_space
}

output "project" {
  value = var.project
}

output "vnet_id" {
  value = azurerm_virtual_network.base_net.id
}

output "vnet_name" {
  value = azurerm_virtual_network.base_net.name
}

output "vnet_rg_name" {
  value = azurerm_resource_group.base_netrg.name
}

output "location" {
  value = azurerm_resource_group.base_netrg.location
}