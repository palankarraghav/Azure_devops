resource "azurerm_log_analytics_workspace" "la" {
  name                = var.loganalytics_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_name
  retention_in_days   = 90
  tags = {env=var.env}
}

resource "azurerm_private_endpoint" "la_pe" {
  name                = "${azurerm_log_analytics_workspace.la.name}-private-endpoint"
  location            = azurerm_log_analytics_workspace.la.location
  resource_group_name = azurerm_log_analytics_workspace.la.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${azurerm_log_analytics_workspace.la.name}-privatelink"
    private_connection_resource_id = azurerm_log_analytics_workspace.la.id
    subresource_names              = ["workspaceloganalytics"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_a_record" "la_a_record" {
  name                = var.loganalytics_name
  zone_name           = "privatelink.oms.opinsights.azure.com"
  resource_group_name = azurerm_log_analytics_workspace.la.resource_group_name
  ttl                 = 300
  records = [azurerm_private_endpoint.la_pe.private_service_connection[0].private_ip_address] 
}
