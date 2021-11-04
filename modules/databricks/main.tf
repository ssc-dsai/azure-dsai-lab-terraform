# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Databricks workspace
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_databricks_workspace" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  # customer_managed_key_enabled = true
  managed_resource_group_name = "${var.name}-rg"

  tags = var.tags
}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Databricks Cluster
# ---------------------------------------------------------------------------------------------------------------------

data "databricks_node_type" "smallest" {
  depends_on = [azurerm_databricks_workspace.this]
  local_disk = true
}

data "databricks_spark_version" "latest_lts" {
  depends_on = [azurerm_databricks_workspace.this]
  long_term_support = true
}

resource "databricks_cluster" "main" {
  cluster_name            = var.cluster_name
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20
  autoscale {
    min_workers = 1
    max_workers = 2
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create Access policy to Key Vault
# ---------------------------------------------------------------------------------------------------------------------

resource "databricks_secret_scope" "kv" {
  depends_on = [
    azurerm_databricks_workspace.this,
    databricks_cluster.main
  ]
  name = "keyvault-managed"

  keyvault_metadata {
    resource_id = var.key_vault_id
    dns_name = var.key_vault_uri
  }
}