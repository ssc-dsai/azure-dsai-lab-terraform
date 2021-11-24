variable "access_key_secret_name" {
  description = "Specifies the name of the secret name key for the Datalake"
  type = string
}

variable "adf_ip_address" {
  description = "Specifies the IP address to whitelist in the SQL Server for the Azure Data Factory"
  type = string
}

variable "administrator_secret_name" {
  description = "Specifies the name of the secret name key for the SQL server password"
  type = string
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR"
  type        = string
  default = "10.0.0.0/16"
}

variable "costcenter" {
  description = "cost center name to be used when tagging resources"
  type        = string
}

variable "env" {
  description = "Environment name to be used"
  type        = string
}

variable "group" {
  description = "A group prefix used for all resources in this example"
  type = string
}

variable "group_lc" {
  description = "A group prefix used for all resources in this example in lowercase"
  type = string
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "prefix" {
  description = "A prefix used for all resources in this example"
  type        = string
}
variable "prefix_lc" {
  description = "A prefix used for all resources in this example in lowercase"
  type        = string
}

variable "location" {
  description = "The location in which all resources in this example should be provisioned"
  type        = string
}

variable "ssn" {
  description = "ssn name to be used when tagging resources"
  type        = string
}

variable "ssc_vpn_ip_address" {
  description = "Specifies the IP address to whitelist in the SQL Server for SSC Users"
  type = string
}

variable "subowner" {
  description = "subowner name to be used when tagging resources"
  type        = string
}

variable "user_defined" {
  type        = string
  description = "the name used for all resources in this example"
}

variable "user_defined_lc" {
  description = "the name used for all resources in this example in lowercase"
  type        = string
}



