resource "azurerm_subnet" "subnet" {
  name =  var.subnet_name
  resource_group_name =  var.resource_group_name
  address_prefixes =  [var.subnet_address]
  virtual_network_name = var.vnet_name
}

resource "azurerm_network_security_group" "nsg" {
  name = var.nsg_name
  location = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_conn" {
  subnet_id = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}