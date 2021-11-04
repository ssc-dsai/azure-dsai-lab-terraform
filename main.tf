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
# Key vault
# ---------------------------------------------------------------------------------------------------------------------

module "keyvault" {
  source = "./modules/keyvault"

  name                = "${var.prefix}CSV-${var.group}-${var.user_defined}-kv"
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
# Databricks
# ---------------------------------------------------------------------------------------------------------------------

module "databricks" {
  source = "./modules/databricks"

  name                = "${var.prefix}CPS-${var.group}-${var.user_defined}-${var.env}-dbw"
  cluster_name        = "Cheapest"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location
  key_vault_id        = module.keyvault.key_vault_id
  key_vault_uri       = module.keyvault.key_vault_uri

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
  source = "./modules/datalake"

  name                      = "${var.prefix_lc}csa${var.group_lc}${var.user_defined_lc}dls1"
  resource_group_name       = module.rg.resource_group_name
  location                  = module.rg.resource_group_location
  allow_blob_public_access  = true
  access_key_secret_name    = "storage-account-access-key"
  key_vault_id              = module.keyvault.key_vault_id

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.rg, module.keyvault]

}

# ---------------------------------------------------------------------------------------------------------------------
# SQL Server
# ---------------------------------------------------------------------------------------------------------------------

module "sqlserver" {
  source = "./modules/sqlserver"

  name                      = "${var.prefix_lc}csa${var.group_lc}${var.user_defined_lc}${var.env}sql"
  database_name             = "${var.prefix}-${var.group}-${var.user_defined}-${var.env}-sdb"
  resource_group_name       = module.rg.resource_group_name
  location                  = module.rg.resource_group_location
  key_vault_name            = module.keyvault.name
  administrator_user_login  = "dsai-sql-admin"
  administrator_secret_name = "sql-admin-login-password"
  adf_ip_address            = var.adf_ip_address
  ssc_vpn_ip_address        = var.ssc_vpn_ip_address

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

  workspace_name        = "${var.prefix}CPS-${var.group}-${var.user_defined}-${var.env}-mlw"
  app_insights_name     = "${var.prefix_lc}cps${var.group_lc}${var.user_defined_lc}${var.env}mlw"
  cluster_name          = "MLCluster-med"
  vm_size               = "Standard_DS3_v2"
  resource_group_name   = module.rg.resource_group_name
  location              = module.rg.resource_group_location
  key_vault_id          = module.keyvault.key_vault_id
  storage_account_id    = module.datalake.storage_account_id
  container_registry_id = module.containerregistry.container_registry_id

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.rg, module.keyvault, module.datalake, module.containerregistry]

}

# ---------------------------------------------------------------------------------------------------------------------
# Data Factory Workspace
# ---------------------------------------------------------------------------------------------------------------------

module "datafactory" {
  source = "./modules/datafactory"

  name                = "${var.prefix}CPS-${var.group}-${var.user_defined}-${var.env}-adf"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location

  # Key vault link
  key_vault_id = module.keyvault.key_vault_id

  # Storage account link
  storage_account_name  = module.datalake.name
  csa_connection_string = module.datalake.primary_connection_string

  # SQL server link
  sql_connection_string = module.sqlserver.connection_string
  secret_name           = module.sqlserver.administrator_secret_name

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.rg, module.keyvault, module.datalake, module.sqlserver]

}

# ---------------------------------------------------------------------------------------------------------------------
# Container Registry
# ---------------------------------------------------------------------------------------------------------------------

module "containerregistry" {
  source = "./modules/containerregistry"

  name                = "${var.prefix_lc}cps${var.group_lc}${var.user_defined_lc}${var.env}acr"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location
  key_vault_id        = module.keyvault.key_vault_id

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }
}
