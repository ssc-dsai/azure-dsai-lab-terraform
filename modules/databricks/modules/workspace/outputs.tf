
# output "databricks_tenant_id" {
#   value = azurerm_databricks_workspace.workspace.storage_account_identity.0.tenant_id
# }

# output "databricks_principal_id" {
#   value = azurerm_databricks_workspace.workspace.storage_account_identity.0.principal_id
# }

output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.workspace.workspace_url}/"
}