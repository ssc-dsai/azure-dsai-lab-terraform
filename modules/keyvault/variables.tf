variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "name" {
  description = "Specifies the name of the Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create"
  type        = string
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  type = string
  default = "standard"  
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
}