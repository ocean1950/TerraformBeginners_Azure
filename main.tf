terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "990ddbdf-bcea-4f83-beb2-7c36343c8770"
  tenant_id = "576feb8d-023e-4ab0-97f5-c3a3dd062e20"
  client_id = "a449e5d0-f284-401d-9d0d-c0b8a1b58e07"
  client_secret = "Z1j8Q~haPpPUQ~~1M0-cv73-AaLUCBn-f3M4laii"

  features {
    
  }
}

resource "azurerm_resource_group" "mkt-rsg" {
  name     = local.resource_group_name
  location = local.location
}

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
  

  subnet {
    name           = "subnet1"
    address_prefix = "11.0.0.0/24"
    security_group = azurerm_network_security_group.mkt-netsec.id


  }

  subnet {
    name           = "subnet2"
    address_prefix = "11.0.1.0/24"
    security_group = azurerm_network_security_group.mkt-netsec.id
  }

  subnet {
    name           = "subnet3"
    address_prefix = "11.0.2.0/24"
    security_group = azurerm_network_security_group.mkt-netsec.id
  }

  depends_on = [ 
    azurerm_network_security_group.mkt-netsec,
    azurerm_resource_group.mkt-rsg
    ]

}


