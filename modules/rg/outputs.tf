output "resource_group_id" {
  value       = azurerm_resource_group.this.id
  description = "Resource group generated id"
}

output "resource_group_location" {
  value       = azurerm_resource_group.this.location
  description = "Resource group location (region)"
}

output "resource_group_name" {
  value       = azurerm_resource_group.this.name
  description = "Resource group name"
}