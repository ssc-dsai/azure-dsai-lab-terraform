output "server_name" {
  value = azurerm_sql_database.this.server_name
}

output "database_name" {
  value = var.database_name
}