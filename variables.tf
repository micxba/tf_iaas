variable "resourcegroup_name" {
  description = "Provide the name of the Resource Group"
}
variable "resourcegroup_location" {
  description = "Specify the location for the resource group and this will apply to all the resources inside this resource group"
}
variable "webtiervms_name" {
  description = "Pass the list of web servers to be created"
}
variable "webtier_security_rules" {
  description = "Pass the web tier Security Rule blocks. Can pass a empty list if no rules are to be attached"
}
variable "webtier_vms_admin_password" {
  description = "Provide the password for the virtual machines provisioned in webtier"
}
variable "webtier_vms_admin_username" {
  description = "Provide the username for the virtual machines provisioned in web tier "
}
variable "webtier_vms_size" {
  description = "Provide the size of the virtualmachines to be created in web tier"
}
variable "apptier_security_rules" {
  description = "Pass the app tier Security Rule blocks. Can pass a empty list if no rules are to be attached"
}
variable "apptiervms_name" {
  description = "Pass the list of app servers to be created"
}
variable "apptier_vms_admin_password" {
  description = "Provide the password for the virtual machines provisioned in app tier"
}
variable "apptier_vms_admin_username" {
  description = "Provide the username for the virtual machines provisioned in app tier "
}
variable "apptier_vms_size" {
  description = "Provide the size of the virtualmachines to be created in app tier"
}
variable "databasetier_security_rules" {
  description = "Pass the database tier Security Rule blocks. Can pass a empty list if no rules are to be attached"
}
variable "databasetiervms_name" {
  description = "Pass the list of database servers to be created"
}
variable "databasetier_vms_admin_password" {
  description = "Provide the password for the virtual machines provisioned in database tier"
}
variable "databasetier_vms_admin_username" {
  description = "Provide the username for the virtual machines provisioned in database tier "
}
variable "databasetier_vms_size" {
  description = "Provide the size of the virtualmachines to be created in database tier"
}