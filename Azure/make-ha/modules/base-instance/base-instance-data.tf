data "azurerm_image" "packer" {
  name = (var.is_public == true ? "packer-nginx-img" : "packer-mariadb-img")
  resource_group_name = var.packer_rg
}
