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
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "mkt-rsg" {
  name     = local.resource_group_name
  location = local.location
}




