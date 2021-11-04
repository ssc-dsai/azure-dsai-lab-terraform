variable "app_insights_name" {
  description = "Specifies the name of the Application Insight"
  type        = string
}

variable "application_type" {
  description = "Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure."
  type = string
  default = "web"
}

variable "container_registry_id" {
  description = "The ID of the container registry associated with this Machine Learning Workspace."
  type        = string
}

variable "cluster_name" {
  description = "Specifies the name of the Machine Learning Cluster"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of key vault associated with this Machine Learning Workspace."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create"
  type        = string
}

variable "storage_account_id" {
    description = "The ID of the Storage Account associated with this Machine Learning Workspace."
    type = string
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
}

variable "vm_priority" {
  description = "The priority of the VM. Changing this forces a new Machine Learning Compute Cluster to be created. Accepted values are Dedicated and LowPriority."
  type        = string
  default     = "LowPriority"
}

variable "vm_size" {
  description = "The size of the VM. Changing this forces a new Machine Learning Compute Cluster to be created."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "workspace_name" {
  description = "Specifies the name of the Machine Learning Workspace"
  type        = string
}