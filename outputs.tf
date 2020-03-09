output "resourcegroup_id" {
  value = azurerm_resource_group.poc_resourcegroup.id
}
output "resourcegroup_name" {
  value = azurerm_resource_group.poc_resourcegroup.name
}
output "resourcegroup_location" {
  value = azurerm_resource_group.poc_resourcegroup.location
}
output "virtualnetwork_name" {
  value = azurerm_virtual_network.poc_virtualnetwork.name
}
output "virtualnetwork_id" {
  value = azurerm_virtual_network.poc_virtualnetwork.id
}
output "virtualnetwork_address_space" {
  value = azurerm_virtual_network.poc_virtualnetwork.address_space
}
output "webtier_subnet_id" {
  value = azurerm_subnet.webtier_subnet.id
}
output "webtier_subnet_name" {
  value = azurerm_subnet.webtier_subnet.name
}
output "webtier_subnet_address_prefix" {
  value = azurerm_subnet.webtier_subnet.address_prefix
}
output "webtier_publicps_id" {
  value = azurerm_public_ip.webtier_publicips.*.id
}
output "webtier_publicps_name" {
  value = azurerm_public_ip.webtier_publicips.*.name
}
output "webtier_publicps_ip_address" {
  value = azurerm_public_ip.webtier_publicips.*.ip_address
}
output "webtier_networksecuritygroup_name" {
  value = azurerm_network_security_group.webtier_nsg.name
}
output "webtier_networksecuritygroup_id" {
  value = azurerm_network_security_group.webtier_nsg.id
}
output "webtier_nic_ids" {
  value = azurerm_network_interface.webtier_nics.*.id
}
output "webtier_vms_id" {
  value = azurerm_windows_virtual_machine.webtier_vms.*.id
}
output "webtier_vms_public_ip" {
  value = azurerm_windows_virtual_machine.webtier_vms.*.public_ip_address
}
output "apptier_subnet_id" {
  value = azurerm_subnet.apptier_subnet.id
}
output "apptier_subnet_name" {
  value = azurerm_subnet.apptier_subnet.name
}
output "apptier_subnet_address_prefix" {
  value = azurerm_subnet.apptier_subnet.address_prefix
}
output "apptier_networksecuritygroup_name" {
  value = azurerm_network_security_group.apptier_nsg.name
}
output "apptier_networksecuritygroup_id" {
  value = azurerm_network_security_group.apptier_nsg.id
}
output "apptier_nic_ids" {
  value = azurerm_network_interface.apptier_nics.*.id
}
output "apptier_vms_id" {
  value = azurerm_windows_virtual_machine.apptier_vms.*.id
}
output "apptier_vms_public_ip" {
  value = azurerm_windows_virtual_machine.apptier_vms.*.public_ip_address
}
output "databasetier_subnet_id" {
  value = azurerm_subnet.databasetier_subnet.id
}
output "databasetier_subnet_name" {
  value = azurerm_subnet.databasetier_subnet.name
}
output "databasetier_subnet_address_prefix" {
  value = azurerm_subnet.databasetier_subnet.address_prefix
}
output "databasetier_networksecuritygroup_name" {
  value = azurerm_network_security_group.databasetier_nsg.name
}
output "databasetier_networksecuritygroup_id" {
  value = azurerm_network_security_group.databasetier_nsg.id
}
output "databasetier_nic_ids" {
  value = azurerm_network_interface.databasetier_nics.*.id
}
output "databasetier_vms_id" {
  value = azurerm_windows_virtual_machine.databasetier_vms.*.id
}
output "databasetier_vms_public_ip" {
  value = azurerm_windows_virtual_machine.databasetier_vms.*.public_ip_address
}
