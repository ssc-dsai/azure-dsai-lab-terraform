# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Application Insights
# ---------------------------------------------------------------------------------------------------------------------
resource "azurerm_application_insights" "this" {
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type
}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Machine Learning Workspace
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_machine_learning_workspace" "this" {
  name                    = var.workspace_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = azurerm_application_insights.this.id
  key_vault_id            = var.key_vault_id
  storage_account_id      = var.storage_account_id
  container_registry_id   = var.container_registry_id

  identity {
    type = "SystemAssigned"
  }
}