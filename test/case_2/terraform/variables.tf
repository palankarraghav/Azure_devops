variable "management_rsg" {
  type = string
}

variable "location" {
  type = string
}

variable "services_rsg" {
  type = string
}

variable "env" {
  type = string
}
#--Vnet 
variable "vnet_rsg" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "vnet_address_space" {
  type = string
}

#--Subnet
variable "subnet_name" {
  type = string
}

variable "subnet_address" {
  type = string
}

variable "nsg_name" {
  type = string
}

#--Key Vault

variable "kv_name" {
  type = string
}

variable "kv_sku" {
  type = string
}

#-- Storage Account

variable "storage_name" {
  type = string
}

variable "storage_account_type" {
  type = string
}

variable "access_tier" {
  type = string
}

variable "account_kind" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

#-- Windows VM
variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

#--LA

variable "loganalytics_name" {
  type = string
}

variable "log_analytics_sku" {
  type = string
}
