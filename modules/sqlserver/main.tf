
data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "admin-login-pwd-secret" {
  name         = "sql-admin-login-password"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_sql_server" "sqlserver" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "dsai-sql-admin"
  administrator_login_password = data.azurerm_key_vault_secret.admin-login-pwd-secret.value

  extended_auditing_policy {
    retention_in_days = 7
  }

  tags = var.tags
}

