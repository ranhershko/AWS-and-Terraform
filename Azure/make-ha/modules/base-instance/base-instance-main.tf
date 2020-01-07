resource "azurerm_resource_group" "instances_rg" {
  name     = "${var.project["prefix_name"]}-(${var.is_public} == true ? 'web' : 'db')-inst-rg"
  location = var.location
}

resource "azurerm_storage_account" "inst_stor" {
  name                     = "${var.project["prefix_name"]}-(${var.is_public} == true ? 'web' : 'db')-inst-stor-rg"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.instances_rg.name
  account_tier             = var.stor_account_tier
  account_replication_type = var.stor_account_repl_type
}

resource "azurerm_availability_set" "avset" {
  name                         = "${var.project["prefix_name"]}-vm-(${var.is_public} == true ? 'web' : 'db')-avset"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.instances_rg.name
  platform_fault_domain_count  = var.availability_set_domain_count
  platform_update_domain_count = var.availability_set_domain_count
  managed                      = true
}

resource "azurerm_network_interface" "nic" {
  name                = "vm-(${var.is_public} == true ? 'web' : 'db')${count.index + 1}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.instances_rg.name
  count               = var.resources_count

  ip_configuration {
    name                                    = "vm-(${var.is_public} == true ? 'web' : 'db')${count.index + 1}-ipconfig"
    subnet_id                               = var.subnet_ids[count.index]
    private_ip_address_allocation           = "Dynamic"
    public_ip_address_id                    = azurerm_public_ip.web_pubip[count.index].id
    #load_balancer_backend_address_pools_ids = [
    #  azurerm_lb_backend_address_pool.backend_pool.id]
    #load_balancer_inbound_nat_rules_ids     = ["${element(azurerm_lb_nat_rule.tcp.*.id, count.index)}"]
  }
}

resource "azurerm_public_ip" "web_pubip" {
  count               = (var.is_public == true ? var.resources_count : 0)
  name                = "vm-web'${count.index + 1}-pubip"
  location            = var.location
  resource_group_name = azurerm_resource_group.instances_rg.name
  allocation_method = "Dynamic"
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "vm-(${var.is_public} == true ? 'web' : 'db')${count.index + 1}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.instances_rg.name
  availability_set_id   = azurerm_availability_set.avset.id
  vm_size               = var.vm_size
  network_interface_ids = ["${element(azurerm_network_interface.nic.*.id, count.index)}"]
  count                 = var.resources_count
  delete_os_disk_on_termination = true

  storage_image_reference {
    id = data.azurerm_image.packer.id
  }

  storage_os_disk {
    name          = "vm-(${var.is_public} == true ? 'web' : 'db')${count.index + 1}-osdisk"
    managed_disk_type = var.managed_disk_type
    os_type = var.os_type
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "vm-(${var.is_public} == true ? 'web' : 'db')${count.index + 1}"
    custom_data = ""
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~/.ssh/id_rsa.pub")
      path = "/home/${var.admin_username}/.ssh/authorized_keys"
    }
  }
}
