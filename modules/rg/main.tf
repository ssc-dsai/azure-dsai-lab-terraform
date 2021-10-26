resource "azurerm_resource_group" "main_rg" {
  name = var.name
  location = var.location
  
  tags = var.tags
}