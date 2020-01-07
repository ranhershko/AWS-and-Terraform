resource "azurerm_subnet" "base_subnet" {
  count                = var.resources_count
  name                 = "${var.project["prefix_name"]}-${var.is_public == true ? "pub" : "priv"}sub${count.index + 1}"
  address_prefix       = cidrsubnet(var.vnet_address_space[0], 8, "${var.is_public == true ? count.index : (count.index + var.resources_count)}")
  resource_group_name  = var.vnet_rg_name
  virtual_network_name = var.vnet_name
}

resource "azurerm_network_security_group" "base_security_group" {
  name                = "${var.project["prefix_name"]}-${var.is_public == true ? "ssh22-n-http80" : "ssh22-and-mariadb3306"}-sg"
  location            = var.location
  resource_group_name = var.vnet_rg_name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = (var.is_public == true ? "${data.http.myip.body}/32" : var.vnet_address_space[0])
    destination_address_prefix = cidrsubnet(azurerm_subnet.base_subnet[0].address_prefix, -1, 0)
  }

  security_rule {
    name                       = (var.is_public == true ? "HTTP" : "MARIADB")
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = (var.is_public == true ? "80" : "3306")
    source_address_prefix      = var.vnet_address_space[0]
    destination_address_prefix = cidrsubnet(azurerm_subnet.base_subnet[0].address_prefix, -1, 0)
  }

  tags = merge(local.common_tags, { Name = "${var.project["prefix_name"]}-nsgRuleForSshAnd${var.is_public == true ? "HTTP" : "MARIADB"}" })
}

resource "azurerm_subnet_network_security_group_association" "base_subnet_nsg_associate" {
  network_security_group_id = azurerm_network_security_group.base_security_group.id
  subnet_id                 = azurerm_subnet.base_subnet[count.index].id
  count                     = var.resources_count
}