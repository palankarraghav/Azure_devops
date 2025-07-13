data "azurerm_key_vault" "management-kv" {
  name                = "management-kv"
  resource_group_name = var.management_rsg
}

data "azurerm_key_vault_secret" "vm_admin" {
  name         = "adminusername"
  key_vault_id = data.azurerm_key_vault.management-kv.id
}

data "azurerm_key_vault_secret" "vm_admin_password" {
  name         = "adminpassword"
  key_vault_id = data.azurerm_key_vault.management-kv.id
}

resource "azurerm_resource_group" "networking-rsg" {
  name     = var.vnet_rsg
  location = var.location
}

resource "azurerm_resource_group" "services-rsg" {
  name     = var.services_rsg
  location = var.location
}

module "budget_alert" {
  source         = "./budget-alert"
  management_rsg = var.management_rsg
  env            = var.env
}

module "vnet" {
  source               = "./vnet"
  virtual_network_name = var.virtual_network_name
  resource_group_name  = azurerm_resource_group.networking-rsg.name
  location             = var.location
  address_space        = var.vnet_address_space
}

module "services_subnet" {
  source              = "./subnet"
  subnet_name         = var.subnet_name
  location            = azurerm_resource_group.networking-rsg.name
  resource_group_name = azurerm_resource_group.networking-rsg.name
  subnet_address      = var.subnet_address
  nsg_name            = var.nsg_name
  vnet_name           = module.vnet.vnet_id
}

module "kv" {
  source              = "./kv"
  kv_name             = var.kv_name
  kv_sku              = var.kv_sku
  location            = azurerm_resource_group.services-rsg.location
  resource_group_name = azurerm_resource_group.services-rsg.name
  subnet_id           = module.services_subnet.subnet_id
  la_workspace_id     = module.la.la-id
  env                 = var.env
}

module "storage" {
  source                   = "./storage"
  storage_name             = var.storage_name
  location                 = azurerm_resource_group.services-rsg.location
  resource_group_name      = azurerm_resource_group.services-rsg.name
  access_tier              = var.access_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  account_tier             = var.access_tier
  subnet_id                = module.services_subnet.subnet_id
  la_workspace_id          = module.la.la-id
  env                      = var.env
}

module "windows-vm" {
  source               = "./vm"
  vm_name              = var.vm_name
  resource_group_name  = azurerm_resource_group.services-rsg.name
  location             = azurerm_resource_group.services-rsg.location
  vm_size              = var.vm_size
  admin_username       = data.azurerm_key_vault_secret.vm_admin.value
  admin_password       = data.azurerm_key_vault_secret.vm_admin_password.value
  subnet_id            = module.services_subnet.subnet_id
  storage_account_type = var.storage_account_type
  la_workspace_id      = module.la.la-id
  env                  = var.env
}

module "la" {
  source              = "./log-analytics"
  loganalytics_name   = var.loganalytics_name
  resource_group_name = azurerm_resource_group.services-rsg.name
  location            = azurerm_resource_group.services-rsg.location
  sku_name            = var.log_analytics_sku
  subnet_id           = module.services_subnet.subnet_id
  env                 = var.env
}
