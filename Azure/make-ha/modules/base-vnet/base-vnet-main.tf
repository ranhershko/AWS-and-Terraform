resource "azurerm_resource_group" "base_netrg" {
    location = var.location
    name = "${var.project["prefix_name"]}-vnetrg"
    tags = merge(local.common_tags, {"Name" = "${var.project["prefix_name"]}-vnetrg"})
}

resource "azurerm_virtual_network" "base_net" {
    address_space = var.vnet_address_space
    location = var.location
    name = "${var.project["prefix_name"]}-vnet"
    resource_group_name = azurerm_resource_group.base_netrg.name
    tags = merge(local.common_tags, {"Name" = "${var.project["prefix_name"]}-vnet"})
}

resource "azurerm_subnet" "base_pub_subnet" {
    name = "${var.project["prefix_name"]}-pusub1"
    address_prefix = var.subnet1_address_prefix
    resource_group_name = azurerm_resource_group.base_netrg.name
    virtual_network_name = azurerm_virtual_network.base_net.name
    //    tags = merge(local.common_tags, {"Name" = "${var.project["prefix_name"]}-pusub1"})
}

resource "azurerm_subnet" "base_priv_subnet" {
    name = "${var.project["prefix_name"]}-privsub1"
    address_prefix = var.subnet2_address_prefix
    resource_group_name = azurerm_resource_group.base_netrg.name
    virtual_network_name = azurerm_virtual_network.base_net.name
    //    tags = merge(local.common_tags, {"Name" = "${var.project["prefix_name"]}-privsub1"})
}

resource "azurerm_resource_group" "netwatcher" {
  count    = var.netwatcher != null ? 1 : 0
  name     = "NetworkWatcherRG"
  location = var.location
}

resource "azurerm_network_watcher" "netwatcher" {
  count               = var.netwatcher != null ? 1 : 0
  name                = "NetworkWatcher_${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.netwatcher.0.name
}
