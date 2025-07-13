resource "azurerm_network_interface" "vm_nic" {
  name =  var.vm_name
  resource_group_name =  var.resource_group_name
  location = var.location
  ip_configuration {
    name = "${var.vm_name}-nic"
    subnet_id = var.subnet_id
    private_ip_address_allocation =  "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name =  var.vm_name
  resource_group_name =  var.resource_group_name
  location =  var.location
  size = var.vm_size
  os_disk {
     caching = "ReadWrite"
     storage_account_type = var.storage_account_type
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  admin_username =  var.admin_username
  admin_password = var.admin_password
  network_interface_ids =  [azurerm_network_interface.vm_nic.id]
  tags = {env=var.env}
}

resource "azurerm_monitor_diagnostic_setting" "vm_diag" {
  name                       = "${var.vm_name}-diag"
  target_resource_id         = azurerm_windows_virtual_machine.vm.id
  log_analytics_workspace_id = var.la_workspace_id

  enabled_log {
    category = "AuditEvent"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}