resource "azurerm_resource_group" "rg" {
  name     = var.instance_rg_name
  location = var.location
}

resource "azurerm_storage_account" "stor" {
  name                     = "${var.project["prefix_name"]}-instance-stor"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = var.sa_account_tier
  account_replication_type = var.sa_replic_type
}

resource "azurerm_availability_set" "avset" {
  name                         = "${var.project["prefix_name"]}-avset"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.rg.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}

resource "azurerm_network_interface" "nic" {
  name                = "nic${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  count               = 2

  ip_configuration {
    name                                    = "ipconfig${count.index}"
    subnet_id                               = var.subnet_id
    private_ip_address_allocation           = "Dynamic"
    load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.backend_pool.id}"]
    load_balancer_inbound_nat_rules_ids     = ["${element(azurerm_lb_nat_rule.tcp.*.id, count.index)}"]
  }
}

resource "azurerm_image_template" "packer" {
  template_uri = var.packer_img_uri
}

resource "azurerm_image" "image" {
  source_template_id = "${azurerm_image_template.packer.id}"
  location = var.location
  name = "${var.project["prefix_name"]}-azure-img-name"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "vm${count.index}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  availability_set_id   = "${azurerm_availability_set.avset.id}"
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${element(azurerm_network_interface.nic.*.id, count.index)}"]
  count                 = 2

  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }

  storage_os_disk {
    name          = "osdisk${count.index}"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${var.hostname}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_windows_config {}
}

resource "azurerm_virtual_machine" "vm" {
  storage_image_reference {
    id = "${azurerm_image.image.id}"
  }
}
