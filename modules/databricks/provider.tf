
terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.9"
    }
  }
}

provider "databricks" {
  host = azurerm_databricks_workspace.this.workspace_url
}