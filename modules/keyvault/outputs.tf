output "name" {
  value = var.name
}
output "key_vault_id" {
  value = azurerm_key_vault.keyvault.id
}