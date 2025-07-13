management_rsg = "nonProd-management-rsg"
location       = "eastus"
services_rsg   = "nonProd-services-rsg"
env            = "nonProd"

#--Vnet 
vnet_rsg             = "nonProd-net-rsg"
virtual_network_name = "nonProd-vnet"
vnet_address_space   = "10.0.0.16"

#--Subnet
subnet_name    = "services-subnet"
subnet_address = "10.1.1/0/16"
nsg_name       = "nonProd-services-nsg"

#--Key Vault
kv_name = "nonProd-kv"
kv_sku  = "standard"

#-- Storage Account
storage_name             = "nonProd-storage"
storage_account_type     = "storageV2"
account_kind             = "StorageV2"
access_tier              = "Cool"
account_tier             = "Standard"
account_replication_type = "ZRS"

#-- Windows VM
vm_name = "nonProd-vm"
vm_size = "D4s_v3"

#--LA
loganalytics_name = "nonProd-la"
log_analytics_sku = "PerGB2018"
