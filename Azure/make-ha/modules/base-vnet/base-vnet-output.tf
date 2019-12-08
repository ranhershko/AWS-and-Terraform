output "vnet_address" {
  value = azurerm_virtual_network.base_net.address_space
}

output "project" {
  value = var.project["prefix_name"]
}

output "vnet_id" {
  value = azurerm_virtual_network.base_net.id
}