# Provide the name of the Resource Group
resourcegroup_name = "poc_product"

# Specify the location for the resource group and this will apply to all the resources inside this resource group
resourcegroup_location = "westus"

# Pass the list of web servers to be created
webtiervms_name = ["webserver1", "webserver2"]

# Pass the web tier Security Rule blocks
webtier_security_rules = [
  {
    rule_name                  = "Allow-Http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    rule_name                  = "Allow-RDP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

# Provide the password for the virtual machines provisioned in webtier
webtier_vms_admin_password = "webtier@123"

# Provide the username for the virtual machines provisioned in web tier
webtier_vms_admin_username = "webuser"

# Provide the size of the virtualmachines to be created in web tier
webtier_vms_size = "Standard_F2"

# Pass the app tier Security Rule blocks
apptier_security_rules = [
  {
    rule_name                  = "Allow-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

# Pass the list of appservers to be created
apptiervms_name = ["appserver1", "appserver2"]

# Provide the password for the virtual machines provisioned in webtier
apptier_vms_admin_password = "apptier@123"

# Provide the username for the virtual machines provisioned in web tier
apptier_vms_admin_username = "appuser"

# Provide the size of the virtualmachines to be created in web tier
apptier_vms_size = "Standard_F2"

# Pass the database tier Security Rule blocks
databasetier_security_rules = [

]

# Pass the list of database servers to be created
databasetiervms_name = ["databaseserver1"]

# Provide the password for the virtual machines provisioned in database tier
databasetier_vms_admin_password = "databasetier@123"

# Provide the username for the virtual machines provisioned in database tier
databasetier_vms_admin_username = "databaseuser"

# Provide the size of the virtualmachines to be created in database tier
databasetier_vms_size = "Standard_F2"