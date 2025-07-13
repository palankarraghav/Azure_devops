resource "azurerm_storage_account" "stg" {
  name = var.storage_name
  resource_group_name = var.resource_group_name
  location = var.location
  access_tier = var.access_tier
  account_kind =  var.account_kind
  account_tier =  var.account_tier
  account_replication_type = var.account_replication_type
  tags = {env=var.env}
}

resource "azurerm_private_endpoint" "storage_pe" {
  name                = "${azurerm_storage_account.stg.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "storage-privatesc"
    private_connection_resource_id = azurerm_storage_account.stg.id
    subresource_names              = ["blob"]  
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_a_record" "la_a_record" {
  name                = var.storage_name
  zone_name           = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_storage_account.stg.resource_group_name
  ttl                 = 300
  records = [azurerm_private_endpoint.storage_pe.private_service_connection[0].private_ip_address] 
}

resource "azurerm_monitor_diagnostic_setting" "kv_diag" {
  name                       = "${var.storage_name}-diag"
  target_resource_id         = azurerm_storage_account.stg.id
  log_analytics_workspace_id = var.la_workspace_id

  enabled_log {
    category = "AuditEvent"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}
