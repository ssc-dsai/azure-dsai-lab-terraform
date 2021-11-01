output "administrator_login" {
  value = azurerm_sql_server.this.administrator_login
}

output "database_name" {
  value = var.database_name
}

output "server_name" {
  value = azurerm_sql_database.this.server_name
}
