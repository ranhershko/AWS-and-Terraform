output "pub_sub_count" {
  value = (var.is_public == true ? length(azurerm_subnet.base_subnet) : 0)
}

output "priv_sub_count" {
  value = (var.is_public == false ? length(azurerm_subnet.base_subnet) : 0)
}

output "public_subnet_ids" {
  value = (var.is_public == true && length(azurerm_subnet.base_subnet) > 0 ? azurerm_subnet.base_subnet.*.id : [])
}

output "private_subnet_ids" {
  value = (var.is_public == false && length(azurerm_subnet.base_subnet) > 0 ? azurerm_subnet.base_subnet.*.id : [])
}