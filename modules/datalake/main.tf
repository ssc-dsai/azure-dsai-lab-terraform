# ---------------------------------------------------------------------------------------------------------------------
# Data
# ---------------------------------------------------------------------------------------------------------------------
data "azurerm_client_config" "current" {}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Storage Account
# ---------------------------------------------------------------------------------------------------------------------
resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  allow_blob_public_access = var.allow_blob_public_access

  tags = var.tags
}

# ---------------------------------------------------------------------------------------------------------------------
# Store the Storage Account access key in Azure Key Vault
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_key_vault_secret" "this" {
  name         = var.access_key_secret_name
  value        = azurerm_storage_account.this.primary_access_key
  key_vault_id = var.key_vault_id
}

# ---------------------------------------------------------------------------------------------------------------------
# Store the current Subscription ID in Azure Key Vault
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_key_vault_secret" "subscription_id_secret_name" {
  name         = var.subscription_id_secret_name
  value        = data.azurerm_client_config.current.subscription_id
  key_vault_id = var.key_vault_id
}

# ---------------------------------------------------------------------------------------------------------------------
# Store the current Tenant ID in Azure Key Vault
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_key_vault_secret" "tenant_id_secret_name" {
  name         = var.tenant_id_secret_name
  value        = data.azurerm_client_config.current.tenant_id
  key_vault_id = var.key_vault_id
}