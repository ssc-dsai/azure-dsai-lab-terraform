output "name" {
  value = var.name
}

output "primary_connection_string" {
  value = azurerm_storage_account.this.primary_connection_string
}

output "storage_account_id" {
  value = azurerm_storage_account.this.id
}