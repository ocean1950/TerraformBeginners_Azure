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
  client_secret = "WbO8Q~MSLClufqZXOqDwULdeN2q41ZJ4tGrLfac9"

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




