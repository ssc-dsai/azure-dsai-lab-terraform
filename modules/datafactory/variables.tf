variable "csa_connection_string" {
  description = "Specifies the connection string to connect to the storage account"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault where the access policy should be created."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "name" {
  description = "Specifies the name of the Data Factory Workspace"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create"
  type        = string
}

variable "secret_name" {
  description = "Specified the secret name to get in the Key Vault for the SQL Server connection string"
  type        = string
}

variable "sql_connection_string" {
  description = "Specifies the connection string to connect to the SQL Server"
  type        = string
}

variable "storage_account_name" {
  description = "Specifies the storage account name in which to create a link"
  type        = string
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
}
