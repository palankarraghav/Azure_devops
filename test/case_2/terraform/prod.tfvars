management_rsg = "prod-management-rsg"
location       = "eastus"
services_rsg   = "prod-services-rsg"
env            = "prod"

#--Vnet 
vnet_rsg             = "prod-net-rsg"
virtual_network_name = "prod-vnet"
vnet_address_space   = "10.0.0.16"

#--Subnet
subnet_name    = "services-subnet"
subnet_address = "10.1.1/0/16"
nsg_name       = "prod-services-nsg"

#--Key Vault
kv_name = "prod-kv"
kv_sku  = "standard"

#-- Storage Account
storage_name             = "prod-storage"
storage_account_type     = "storageV2"
account_kind             = "StorageV2"
access_tier              = "Cool"
account_tier             = "Standard"
account_replication_type = "ZRS"

#-- Windows VM
vm_name = "prod-vm"
vm_size = "D4s_v3"

#--LA
loganalytics_name = "prod-la"
log_analytics_sku = "PerGB2018"
