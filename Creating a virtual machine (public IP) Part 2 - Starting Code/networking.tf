resource "azurerm_network_security_group" "mkt-netsec" {
  name                = local.networksecuritygrp
  location            = local.location
  resource_group_name = local.resource_group_name

  depends_on = [ 
    azurerm_resource_group.mkt-rsg 
    ]

}


resource "azurerm_virtual_network" "mkt-virtualnetwork" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.virtual_network.address_space]
  

  depends_on = [ 
    azurerm_resource_group.mkt-rsg
    ]

}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.mkt-virtualnetwork.name
  address_prefixes     = ["11.0.1.0/24"]

}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.mkt-virtualnetwork.name
  address_prefixes     = ["11.0.2.0/24"]

}

resource "azurerm_network_interface" "mkt-netinterface" {
  name                = "mkt-netinterface"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [ 
    azurerm_resource_group.mkt-rsg 
    ]
}

resource "azurerm_network_interface_security_group_association" "mkt-netinterface_associate" {
  network_interface_id      = azurerm_network_interface.mkt-netinterface.id
  network_security_group_id = azurerm_network_security_group.mkt-netsec.id
}