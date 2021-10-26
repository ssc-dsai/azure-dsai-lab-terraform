variable "location" {
  description = "Azure region to use"
  type        = string
}

variable "name" {
  description = "variable used to name the resource group"
  type        = string
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
}