terraform {
  required_version = ">=0.12.17"
}
provider "azurerm" {
  version = ">=2.0.0"
  features {
    virtual_machine {
      delete_os_disk_on_deletion = "true"
    }
  }
}
resource "azurerm_resource_group" "poc_resourcegroup" {
  name     = var.resourcegroup_name
  location = var.resourcegroup_location
}
resource azurerm_virtual_network "poc_virtualnetwork" {
  name                = "${var.resourcegroup_name}_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.poc_resourcegroup.location
  resource_group_name = azurerm_resource_group.poc_resourcegroup.name
}
resource azurerm_subnet "webtier_subnet" {
  name                 = "webtier_subnet"
  address_prefix       = "10.0.1.0/24"
  virtual_network_name = azurerm_virtual_network.poc_virtualnetwork.name
  resource_group_name  = azurerm_resource_group.poc_resourcegroup.name
}
resource "azurerm_public_ip" "webtier_publicips" {
  count               = length(var.webtiervms_name)
  name                = "${element(var.webtiervms_name, count.index)}-ip"
  resource_group_name = azurerm_resource_group.poc_resourcegroup.name
  location            = azurerm_resource_group.poc_resourcegroup.location
  allocation_method   = "Static"
}
resource "azurerm_network_security_group" "webtier_nsg" {
  name                = "webtier_nsg"
  resource_group_name = azurerm_resource_group.poc_resourcegroup.name
  location            = azurerm_resource_group.poc_resourcegroup.location
  dynamic "security_rule" {
    for_each = var.webtier_security_rules
    content {
      name                       = security_rule.value.rule_name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}
resource "azurerm_network_interface_security_group_association" "webtier_nic_nsg_association" {
  count                     = length(var.webtiervms_name)
  network_interface_id      = azurerm_network_interface.webtier_nics[count.index].id
  network_security_group_id = azurerm_network_security_group.webtier_nsg.id
}
resource "azurerm_network_interface" "webtier_nics" {
  count = length(var.webtiervms_name)
  name  = "${element(var.webtiervms_name, count.index)}-nic"
  ip_configuration {
    name                          = "ip_configuration"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.webtier_subnet.id
    public_ip_address_id          = azurerm_public_ip.webtier_publicips[count.index].id
  }
  location            = azurerm_resource_group.poc_resourcegroup.location
  resource_group_name = azurerm_resource_group.poc_resourcegroup.name
}
resource "azurerm_windows_virtual_machine" "webtier_vms" {
  count          = length(var.webtiervms_name)
  name           = element(var.webtiervms_name, count.index)
  location       = azurerm_resource_group.poc_resourcegroup.location
  admin_password = var.webtier_vms_admin_password
  admin_username = var.webtier_vms_admin_username
  network_interface_ids = [
    azurerm_network_interface.webtier_nics[count.index].id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  resource_group_name = azurerm_resource_group.poc_resourcegroup.name
  size                = var.webtier_vms_size
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
resource azurerm_subnet "apptier_subnet" {
  name                 = "apptier_subnet"
  address_prefix       = "10.0.2.0/24"
  virtual_network_name = azurerm_virtual_network.poc_virtualnetwork.name
  resource_group_name  = azurerm_resource_group.poc_resourcegroup.name
}
resource "azurerm_network_security_group" "apptier_nsg" {
  name                = "apptier_nsg"
  resource_group_name = azurerm_resource_group.poc_resourcegroup.name
  location            = azurerm_resource_group.poc_resourcegroup.location
  dynamic "security_rule" {
    for_each = var.apptier_security_rules
    content {
      name                       = security_rule.value.rule_name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}
resource "azurerm_network_interface_security_group_association" "apptier_nic_nsg_association" {
  count                     = length(var.apptiervms_name)
  network_interface_id      = azurerm_network_interface.apptier_nics[count.index].id
  network_security_group_id = azurerm_network_security_group.apptier_nsg.id
}
resource "azurerm_network_interface" "apptier_nics" {
  count = length(var.apptiervms_name)
  name  = "${element(var.apptiervms_name, count.index)}-nic"
  ip_configuration {
    name                          = "ip_configuration"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.apptier_subnet.id
    # public_ip_address_id = azurerm_public_ip.webtier_publicips[count.index].id
  }
  location            = azurerm_resource_group.poc_resourcegroup.location
  resource_group_name = azurerm_resource_group.poc_resourcegroup.name
}
resource "azurerm_windows_virtual_machine" "apptier_vms" {
  count          = length(var.apptiervms_name)
  name           = element(var.apptiervms_name, count.index)
  location       = azurerm_resource_group.poc_resourcegroup.location
  admin_password = var.apptier_vms_admin_password
  admin_username = var.apptier_vms_admin_username
  network_interface_ids = [
    azurerm_network_interface.apptier_nics[count.index].id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  resource_group_name = azurerm_resource_group.poc_resourcegroup.name
  size                = var.apptier_vms_size
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
resource azurerm_subnet "databasetier_subnet" {
  name                 = "databasetier_subnet"
  address_prefix       = "10.0.3.0/24"
  virtual_network_name = azurerm_virtual_network.poc_virtualnetwork.name
  resource_group_name  = azurerm_resource_group.poc_resourcegroup.name
}
resource "azurerm_network_security_group" "databasetier_nsg" {
  name                = "databasetier_nsg"
  resource_group_name = azurerm_resource_group.poc_resourcegroup.name
  location            = azurerm_resource_group.poc_resourcegroup.location
  dynamic "security_rule" {
    for_each = var.databasetier_security_rules
    content {
      name                       = security_rule.value.rule_name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}
resource "azurerm_network_interface_security_group_association" "databasetier_nic_nsg_association" {
  count                     = length(var.databasetiervms_name)
  network_interface_id      = azurerm_network_interface.databasetier_nics[count.index].id
  network_security_group_id = azurerm_network_security_group.databasetier_nsg.id
}
resource "azurerm_network_interface" "databasetier_nics" {
  count = length(var.databasetiervms_name)
  name  = "${element(var.databasetiervms_name, count.index)}-nic"
  ip_configuration {
    name                          = "ip_configuration"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.apptier_subnet.id
    # public_ip_address_id = azurerm_public_ip.webtier_publicips[count.index].id
  }
  location            = azurerm_resource_group.poc_resourcegroup.location
  resource_group_name = azurerm_resource_group.poc_resourcegroup.name
}
resource "azurerm_windows_virtual_machine" "databasetier_vms" {
  count          = length(var.databasetiervms_name)
  name           = element(var.databasetiervms_name, count.index)
  location       = azurerm_resource_group.poc_resourcegroup.location
  admin_password = var.databasetier_vms_admin_password
  admin_username = var.databasetier_vms_admin_username
  network_interface_ids = [
    azurerm_network_interface.databasetier_nics[count.index].id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  resource_group_name = azurerm_resource_group.poc_resourcegroup.name
  size                = var.databasetier_vms_size
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}