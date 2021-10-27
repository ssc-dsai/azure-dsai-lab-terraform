# ---------------------------------------------------------------------------------------------------------------------
# Databricks Workspace
# ---------------------------------------------------------------------------------------------------------------------

module "databricks_workspace" {
    source = "./modules/workspace"

    name                = var.name
    resource_group_name = var.resource_group_name
    location            = var.location    

    tags = var.tags
}

module "databricks_rg" {
    source = "./modules/managed_resource_group"
    dbw_host_url = module.databricks_workspace.databricks_host
}