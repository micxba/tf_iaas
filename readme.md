# POC Environemt using Terraform
## This environment creates:
* 1 Resource Group
* 1 Virtual Network
* 3 Subnets (1 for web tier, 1 for app tier and 1 for database tier)
* 2 Public Ip’s (Only for the web tier)  
_If you modify the number of web servers to be created in the .tfvars file, it adjusts the number of public ip’s accordingly._
* 3 NSG’s ( 1 each for web, app and database tier)  
_This is created because each tier might different set of rulesm like web tier might be exposed over http but database and app are not_
_The security rules are created using dynamic blocks. You can pass in as many rules in tfvars file_  
_Web tier has rdp and http allowed_  
_App tier has only rdp allowed_  
_Database does not have any rules (but can be added in .tfvars, if needed)_  
_NSGS can be attached to either Subnet or NIC. In this Environment they are attached to NIC and NIC’s in turn are associated with VM’s._  
* 5 NIC’s  
_They are grouped into web tier, app tier and database tier because of the association with respective subnet and NSG_  
_Each tier again creates  no of nics based on the servers specified for that tier_  
* 5 VM’s
_2 for web tier_  
_2 for app tier_  
_1 for database tier_  


The vm’s can be added or deleted by modifying the vms_name variable specific to the tier.  The creation or deletion will be grouped i.e., the vm along with its nic and public ip (if web tier) will be created/destroyed.

_This Terraform project has no authentication built in. It relies on the az-cli to authenticate_  
1. `az login`
2. Follow the steps to authenticate via browser.
3. If you have multiple subscriptions or tenants you may have to chose the right one e.g. `az account set --subscription "Visual Studio Professional`