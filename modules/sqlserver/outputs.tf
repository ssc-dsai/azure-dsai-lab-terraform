output "administrator_secret_name" {
  value = azurerm_key_vault_secret.this.name
}
output "connection_string" {
  description = "Connection string for the Azure SQL Database created."
  value       = "Server=tcp:${azurerm_sql_server.this.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.this.name};Persist Security Info=False;User ID=${azurerm_sql_server.this.administrator_login};Password=${azurerm_sql_server.this.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}