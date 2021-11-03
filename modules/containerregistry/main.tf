# ---------------------------------------------------------------------------------------------------------------------
# Creating User Assigned Identity
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "registry-uai"
}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Container Registry
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  identity {
    type = "SystemAssigned, UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id
    ]
  }
}

#  encryption {
#    enabled            = true
#    key_vault_key_id   = data.azurerm_key_vault_key.this.id
#    identity_client_id = azurerm_user_assigned_identity.this.client_id
#  }
