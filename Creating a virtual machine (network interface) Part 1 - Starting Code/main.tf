terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "Your Subscrition ID"
  tenant_id = "Your tenant ID"
  client_id = "Your Client ID"
  client_secret = "Your Client Secret"

  features {
    
  }
}

resource "azurerm_resource_group" "mkt-rsg" {
  name     = local.resource_group_name
  location = local.location
}




