# ---------------------------------------------------------------------------------------------------------------------
# Azure Lab Environment Terraform
# ---------------------------------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------------------------------
# Resource group
# ---------------------------------------------------------------------------------------------------------------------

module "resource_group" {
  source = "git@github.com:SSC-DSAI/terraform-modules.git//azure/rg"

  name     = "${var.prefix}-${var.group}-${var.user_defined}-${var.env}-rg"
  location = var.location

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Management lock - Resource group
# ---------------------------------------------------------------------------------------------------------------------

module "mgmt_lock" {
  source = "git@github.com:SSC-DSAI/terraform-modules.git//azure/managementlock"

  name = "${var.prefix}-${var.group}-${var.user_defined}-${var.env}-mgmtlock"

  resource_group_name = module.resource_group.resource_group_name
}

# ---------------------------------------------------------------------------------------------------------------------
# Key vault
# ---------------------------------------------------------------------------------------------------------------------

module "key_vault" {
  source = "git@github.com:SSC-DSAI/terraform-modules.git//azure/keyvault"

  name                = "${var.prefix}CSV-${var.group}-${var.user_defined}-kv"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.resource_group]

}


# ---------------------------------------------------------------------------------------------------------------------
# Databricks
# ---------------------------------------------------------------------------------------------------------------------

module "databricks" {
  source = "git@github.com:SSC-DSAI/terraform-modules.git//azure/databricks"

  name                = "${var.prefix}CPS-${var.group}-${var.user_defined}-${var.env}-dbw"
  cluster_name        = "Cheapest"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  key_vault_id        = module.key_vault.key_vault_id
  key_vault_uri       = module.key_vault.key_vault_uri

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

}

# ---------------------------------------------------------------------------------------------------------------------
# Data Lake Storage
# ---------------------------------------------------------------------------------------------------------------------

module "datalake" {
  source = "git@github.com:SSC-DSAI/terraform-modules.git//azure/datalake"

  name                     = "${var.prefix_lc}csa${var.group_lc}${var.user_defined_lc}dls1"
  resource_group_name      = module.resource_group.resource_group_name
  location                 = module.resource_group.resource_group_location
  allow_blob_public_access = true
  access_key_secret_name   = var.access_key_secret_name
  key_vault_id             = module.key_vault.key_vault_id

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.resource_group, module.key_vault]

}

# ---------------------------------------------------------------------------------------------------------------------
# SQL Server
# ---------------------------------------------------------------------------------------------------------------------

module "sql_server" {
  source = "git@github.com:SSC-DSAI/terraform-modules.git//azure/sqlserver"

  name                      = "${var.prefix_lc}csa${var.group_lc}${var.user_defined_lc}${var.env}sql"
  database_name             = "${var.prefix}-${var.group}-${var.user_defined}-${var.env}-sdb"
  resource_group_name       = module.resource_group.resource_group_name
  location                  = module.resource_group.resource_group_location
  key_vault_name            = module.key_vault.name
  administrator_user_login  = "dsai-sql-admin"
  administrator_secret_name = var.administrator_secret_name
  adf_ip_address            = var.adf_ip_address
  ssc_vpn_ip_address        = var.ssc_vpn_ip_address

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.resource_group, module.key_vault]

}

# ---------------------------------------------------------------------------------------------------------------------
# Machine Learning Workspace
# ---------------------------------------------------------------------------------------------------------------------

module "ml_workspace" {
  source = "git@github.com:SSC-DSAI/terraform-modules.git//azure/mlworkspace"

  workspace_name        = "${var.prefix}CPS-${var.group}-${var.user_defined}-${var.env}-mlw"
  app_insights_name     = "${var.prefix_lc}cps${var.group_lc}${var.user_defined_lc}${var.env}mlw"
  cluster_name          = "MLCluster-med"
  vm_size               = "Standard_DS3_v2"
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.resource_group_location
  key_vault_id          = module.key_vault.key_vault_id
  storage_account_id    = module.datalake.storage_account_id
  container_registry_id = module.container_registry.container_registry_id

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.resource_group, module.key_vault, module.datalake, module.container_registry]

}

# ---------------------------------------------------------------------------------------------------------------------
# Data Factory Workspace
# ---------------------------------------------------------------------------------------------------------------------

module "datafactory" {
  source = "git@github.com:SSC-DSAI/terraform-modules.git//azure/datafactory"

  name                = "${var.prefix}CPS-${var.group}-${var.user_defined}-${var.env}-adf"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  # Key vault link
  key_vault_id = module.key_vault.key_vault_id

  # Storage account link
  storage_account_name  = module.datalake.name
  csa_connection_string = module.datalake.primary_connection_string

  # SQL server link
  sql_connection_string = module.sql_server.connection_string
  secret_name           = module.sql_server.administrator_secret_name

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.resource_group, module.key_vault, module.datalake, module.sql_server]

}

# ---------------------------------------------------------------------------------------------------------------------
# Container Registry
# ---------------------------------------------------------------------------------------------------------------------

module "container_registry" {
  source = "git@github.com:SSC-DSAI/terraform-modules.git//azure/containerregistry"

  name                = "${var.prefix_lc}cps${var.group_lc}${var.user_defined_lc}${var.env}acr"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }
}
