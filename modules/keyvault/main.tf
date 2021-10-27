data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
}

resource "azurerm_key_vault_access_policy" "terraform" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = azurerm_key_vault.keyvault.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "get",
    "list",
    "create",
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
    "delete",
    "restore",
    "recover",
    "update",
    "purge",
  ]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_key_vault_secret" "sql-admin-pwd-secret" {
  name         = "sql-admin-login-password"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.keyvault.id


}



#TODO: look into this later
# resource "azurerm_key_vault_access_policy" "dbw-akv-policy" {
#   key_vault_id = azurerm_key_vault.keyvault.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = var.object_id

#   secret_permissions = [
#     "Get", "List"
#   ]
# }
