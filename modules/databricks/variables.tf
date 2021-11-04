variable "cluster_name" {
  description = "Variable used to name the Databricks Cluster"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault where the access policy should be created."
  type        = string
}

variable "key_vault_uri" {
  description = "The URI of the Key Vault where the access policy should be created."
  type        = string
}
variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "name" {
  description = "Specifies the name of the Databricks Workspace"
  type        = string
}


variable "resource_group_name" {
  description = "The name of the resource group in which to create"
  type        = string
}

variable "sku" {
  description = "The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial."
  type        = string
  default     = "premium"
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
}