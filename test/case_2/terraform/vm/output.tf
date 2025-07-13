output "vm-nic" {
  value = azurerm_network_interface.vm_nic.id
}

output "vm" {
  value = azurerm_windows_virtual_machine.vm.id
}