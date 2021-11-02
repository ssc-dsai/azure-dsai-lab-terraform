
variable "adf_ip_address" {
  description = "Specifies the IP address to whitelist in the SQL Server for the Azure Data Factory"
  type = string
}
variable "administrator_secret_name" {
  description = "Specifies the name of the Key Vault Secret."
  type = string
}

variable "administrator_user_login" {
  description = "The administrator login name for the new server."
  type = string
}

variable "database_name" {
  description = "Specifies the name of the SQL Database"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault where the access the secret."
  type        = string
}
variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "name" {
  description = "Specifies the name of the SQL Server"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create"
  type        = string
}

variable "sql_server_version" {
  description = "The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
  type = string
  default = "12.0"
}

variable "ssc_vpn_ip_address" {
  description = "Specifies the IP address to whitelist in the SQL Server for SSC Users"
  type = string
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
}