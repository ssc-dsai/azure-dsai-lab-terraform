# ---------------------------------------------------------------------------------------------------------------------
# Creating SQL Server Admin Password and store in Azure Key Vault
# ---------------------------------------------------------------------------------------------------------------------
data "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_key_vault_secret" "this" {
  name         = var.administrator_secret_name
  value        = random_password.this.result
  key_vault_id = data.azurerm_key_vault.this.id
}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure SQL Server
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_sql_server" "this" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_server_version
  administrator_login          = var.administrator_user_login
  administrator_login_password = random_password.this.result

  extended_auditing_policy {
    retention_in_days = 7
  }

  tags = var.tags
}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure SQL Database
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_sql_database" "this" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = azurerm_sql_server.this.name

  extended_auditing_policy {
    retention_in_days = 7
  }

  tags = var.tags
}