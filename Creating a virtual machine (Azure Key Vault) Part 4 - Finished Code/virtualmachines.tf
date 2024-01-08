resource "azurerm_windows_virtual_machine" "mkt-vm01" {
  name                = "mkt-vm01"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "Standard_B4ms"
  admin_username      = "adminuser"
  admin_password      = azurerm_key_vault_secret.mktvmpassword.value
  network_interface_ids = [
    azurerm_network_interface.mkt-netinterface.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-21h2-avd"
    version   = "latest"
  }

  depends_on = [ 
    azurerm_network_interface.mkt-netinterface,
    azurerm_resource_group.mkt-rsg
    ]
}
