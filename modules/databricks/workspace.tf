resource "azurerm_databricks_workspace" "workspace" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "standard"

  tags = var.tags
}
