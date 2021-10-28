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

variable "prenium" {
  description = "variable used to name the resource group"
  type        = string
  default = "premium"
}