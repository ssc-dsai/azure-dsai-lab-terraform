terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.82.0"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.9"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "databricks" {
  host = "https://adb-1219360855249094.14.azuredatabricks.net"
}

