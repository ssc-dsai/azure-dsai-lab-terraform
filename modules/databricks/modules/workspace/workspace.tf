resource "azurerm_databricks_workspace" "workspace" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "premium"

  # customer_managed_key_enabled = true
  managed_resource_group_name = "${var.name}-rg"
  


  tags = var.tags
}

