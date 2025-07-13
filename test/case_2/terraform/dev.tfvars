management_rsg = "dev-management-rsg"
location       = "eastus"
services_rsg   = "dev-services-rsg"
env            = "dev"

#--Vnet 
vnet_rsg             = "dev-net-rsg"
virtual_network_name = "dev-vnet"
vnet_address_space   = "10.0.0.16"

#--Subnet
subnet_name    = "services-subnet"
subnet_address = "10.1.1/0/16"
nsg_name       = "dev-services-nsg"

#--Key Vault
kv_name = "dev-kv"
kv_sku  = "standard"

#-- Storage Account
storage_name             = "dev-storage"
storage_account_type     = "storageV2"
account_kind             = "StorageV2"
access_tier              = "Cool"
account_tier             = "Standard"
account_replication_type = "ZRS"

#-- Windows VM
vm_name = "dev-vm"
vm_size = "D4s_v3"

#--LA
loganalytics_name = "dev-la"
log_analytics_sku = "PerGB2018"
