variable "location" {
  description = "Azure region to use"
  type        = string
}

variable "workspace_name" {
  description = "variable used to name the key vault"
  type        = string
}

variable "app_insights_name" {
  description = "variable used to name the key vault"
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

variable "storage_account_id" {
    description = ""
    type = string
}