
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvltscholars908" {
  name                       = "keyvltscholars908"
  location                   = local.location
  resource_group_name        = local.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "List"
     
    ]
  }
}

resource "azurerm_key_vault_secret" "mktvmpassword" {
  name         = "mktvmpassword"
  value        = random_password.vmgenpassword.result
  key_vault_id = azurerm_key_vault.keyvltscholars908.id
  depends_on = [ 
    azurerm_key_vault.keyvltscholars908 
    ]
}

resource "random_password" "vmgenpassword" {
    length = 12
    special = true
    min_lower = 2
    min_upper = 3
    numeric = true
    override_special = "#$*@!"
  
}