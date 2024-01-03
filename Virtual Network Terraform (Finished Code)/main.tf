terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "Your Subscription ID"
  tenant_id = "Your Tenant ID"
  client_id = "Your Client ID"
  client_secret = "Your client Secret"

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


