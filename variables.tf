variable "cidr" {
  type        = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR"
  default = "10.0.0.0/16"
}

variable "costcenter" {
  type        = string
  description = "cost center name to be used when tagging resources"
}

variable "env" {
  type        = string
  description = "Environment name to be used"
}

variable "group" {
  type = string
  description = "A group prefix used for all resources in this example"
}

variable "group_lc" {
  type = string
  description = "A group prefix used for all resources in this example in lowercase"
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnets inside the VPC"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of private subnets inside the VPC"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "prefix" {
  type        = string
  description = "A prefix used for all resources in this example"
}
variable "prefix_lc" {
  type        = string
  description = "A prefix used for all resources in this example in lowercase"
}

variable "location" {
  type        = string
  description = "The location in which all resources in this example should be provisioned"
}

variable "ssn" {
  type        = string
  description = "ssn name to be used when tagging resources"
}

variable "subowner" {
  type        = string
  description = "subowner name to be used when tagging resources"
}

variable "user_defined" {
  type        = string
  description = "the name used for all resources in this example"
}

variable "user_defined_lc" {
  type        = string
  description = "the name used for all resources in this example in lowercase"
}



