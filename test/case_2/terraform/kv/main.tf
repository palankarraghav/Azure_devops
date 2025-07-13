data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
  name = var.kv_name
  tenant_id = data.azurerm_client_config.current.client_id
  resource_group_name =  var.resource_group_name
  sku_name = var.kv_sku
  location = var.location
  soft_delete_retention_days = 7
  
    network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    virtual_network_subnet_ids = [
      var.subnet_id
    ]
  }
  tags = {env=var.env}
}

resource "azurerm_private_endpoint" "kv_pe" {
  name                = "${var.kv_name}-private-endpoint"
  location            = azurerm_key_vault.kv.location
  resource_group_name = azurerm_key_vault.kv.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.kv_name}-privatesc"
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_a_record" "kv_a_record" {
  name                = var.kv_name
  zone_name           = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_key_vault.kv.resource_group_name
  ttl                 = 300
  records = [azurerm_private_endpoint.kv_pe.private_service_connection[0].private_ip_address] 
}

resource "azurerm_monitor_diagnostic_setting" "kv_diag" {
  name                       = "${var.kv_name}-diag"
  target_resource_id         = azurerm_key_vault.kv.id
  log_analytics_workspace_id = var.la_workspace_id

  enabled_log {
    category = "AuditEvent"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

