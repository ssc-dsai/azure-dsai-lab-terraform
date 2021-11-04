variable "access_key_secret_name" {
  description = "Defines the storage account access key secret name."
  type = string
}

variable "account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  type = string
  default = "StorageV2"
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid."
  type        = string
  default = "Standard"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  type = string
  default = "LRS"
}

variable "allow_blob_public_access" {
  description = "Allow or disallow public access to all blobs or containers in the storage account."
  type = bool
  default = false
}

variable "key_vault_id" {
  description = "The ID of the Key Vault where the access policy should be created."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "name" {
  description = "Specifies the name of the Data lake"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create"
  type        = string
}

variable "subscription_id_secret_name" {
  description = "Defines the Subcription ID secret name."
  type = string
  default = "subscription-id"
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
}

variable "tenant_id_secret_name" {
  description = "Defines the Tenant ID secret name."
  type = string
  default = "tenant-id"
}