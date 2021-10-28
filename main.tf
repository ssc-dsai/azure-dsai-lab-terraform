# ---------------------------------------------------------------------------------------------------------------------
# Azure Lab Environment Terraform
# ---------------------------------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------------------------------
# Resource group
# ---------------------------------------------------------------------------------------------------------------------
module "rg" {
  source = "./modules/rg"

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
# Databricks
# ---------------------------------------------------------------------------------------------------------------------

module "databricks" {
  source = "./modules/databricks"

  name                = "${var.prefix}CPS-${var.group}-${var.user_defined}-${var.env}-dbw"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

}

# ---------------------------------------------------------------------------------------------------------------------
# Key vault
# ---------------------------------------------------------------------------------------------------------------------

module "keyvault" {
  source = "./modules/keyvault"

  name                = "${var.prefix}CSV-${var.group}-${var.user_defined}-${var.env}-kv"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.rg, module.databricks]

}

# ---------------------------------------------------------------------------------------------------------------------
# Data Lake Storage
# ---------------------------------------------------------------------------------------------------------------------

module "datalake" {
  source = "./modules/datalake"

  name                = "${var.prefix_lc}csa${var.group_lc}${var.user_defined_lc}${var.env}dls1"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location


  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.rg]

}

# ---------------------------------------------------------------------------------------------------------------------
# SQL Server
# ---------------------------------------------------------------------------------------------------------------------

module "sqlserver" {
  source = "./modules/sqlserver"

  name                = "${var.prefix_lc}csa${var.group_lc}${var.user_defined_lc}${var.env}sql"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location
  keyvault_name       = "${var.prefix}CSV-${var.group}-${var.user_defined}-${var.env}-kv"

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.rg, module.keyvault]

}

# ---------------------------------------------------------------------------------------------------------------------
# Machine Learning Workspace
# ---------------------------------------------------------------------------------------------------------------------

module "mlworkspace" {
  source = "./modules/mlworkspace"

  workspace_name      = "${var.prefix}CPS-${var.group}-${var.user_defined}-${var.env}-mlw"
  app_insights_name   = "${var.prefix_lc}cps${var.group_lc}${var.user_defined_lc}${var.env}mlw"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location
  key_vault_id        = module.keyvault.key_vault_id
  storage_account_id  = module.datalake.storage_account_id

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.rg, module.keyvault, module.datalake]

}
