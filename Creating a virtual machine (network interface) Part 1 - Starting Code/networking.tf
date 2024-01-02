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
    azurerm_network_security_group.mkt-netsec,
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
