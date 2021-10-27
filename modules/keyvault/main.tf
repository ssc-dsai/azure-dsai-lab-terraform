resource "azurerm_key_vault" "keyvault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
}

resource "azurerm_key_vault_access_policy" "dbw-akv-policy" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_databricks_workspace.workspace.storage_account_identity.0.tenant_id
  object_id    = data.azurerm_databricks_workspace.workspace.storage_account_identity.0.principal_id

  secret_permissions = [
    "Get", "List"
  ]
}
