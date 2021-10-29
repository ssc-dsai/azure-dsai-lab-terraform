output "name" {
  value = var.name
}
output "storage_account_id" {
  value = azurerm_storage_account.datalake.id
}

output "primary_connection_string" {
  value = azurerm_storage_account.datalake.primary_connection_string
}