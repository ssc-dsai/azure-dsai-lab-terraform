variable "location" {
  description = "Azure region to use"
  type        = string
}
variable "name" {
  description = "variable used to name the databricks workspace"
  type        = string
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
}

variable "resource_group_name" {
  description = "variable used to name the resource group"
  type        = string
}

variable "key_vault_id" {
    description = ""
    type = string
}

variable "storage_account_name" {
    description = ""
    type = string
}

variable "csa_connection_string" {
    description = ""
    type = string
}

variable "sql_connection_string" {
    description = ""
    type = string
}

variable "secret_name" {
  description = ""
  type = string
}