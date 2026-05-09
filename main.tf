##############################################################################
# Locals – derive resource names from prefix when overrides are not provided #
##############################################################################

locals {
  ai_foundry_hub_name          = var.ai_foundry_hub_name != "" ? var.ai_foundry_hub_name : "${var.prefix}-hub"
  ai_foundry_project_name      = var.ai_foundry_project_name != "" ? var.ai_foundry_project_name : "${var.prefix}-project"
  storage_account_name         = var.storage_account_name != "" ? var.storage_account_name : "${var.prefix}sa${random_id.suffix.hex}"
  key_vault_name               = var.key_vault_name != "" ? var.key_vault_name : "${var.prefix}-kv-${random_id.suffix.hex}"
  application_insights_name    = var.application_insights_name != "" ? var.application_insights_name : "${var.prefix}-appinsights"
  log_analytics_workspace_name = var.log_analytics_workspace_name != "" ? var.log_analytics_workspace_name : "${var.prefix}-law"
  container_registry_name      = var.container_registry_name != "" ? var.container_registry_name : "${var.prefix}acr${random_id.suffix.hex}"
  ai_services_name             = var.ai_services_name != "" ? var.ai_services_name : "${var.prefix}-aiservices"
}

##############################################################################
# Random suffix – keeps globally-unique resource names collision-free        #
##############################################################################

resource "random_id" "suffix" {
  byte_length = 4
}

##############################################################################
# Data sources                                                                #
##############################################################################

data "azurerm_client_config" "current" {}

##############################################################################
# Resource Group                                                              #
##############################################################################

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

##############################################################################
# Storage Account                                                             #
##############################################################################

resource "azurerm_storage_account" "main" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

##############################################################################
# Key Vault                                                                   #
##############################################################################

resource "azurerm_key_vault" "main" {
  name                       = local.key_vault_name
  resource_group_name        = azurerm_resource_group.main.name
  location                   = azurerm_resource_group.main.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "deployer" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Create",
    "Get",
    "Delete",
    "Purge",
    "GetRotationPolicy",
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Purge",
  ]
}

##############################################################################
# Log Analytics Workspace (backing Application Insights)                      #
##############################################################################

resource "azurerm_log_analytics_workspace" "main" {
  name                = local.log_analytics_workspace_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

##############################################################################
# Application Insights                                                        #
##############################################################################

resource "azurerm_application_insights" "main" {
  name                = local.application_insights_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "web"

  tags = var.tags
}

##############################################################################
# Container Registry                                                          #
##############################################################################

resource "azurerm_container_registry" "main" {
  name                = local.container_registry_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
  admin_enabled       = false

  tags = var.tags
}

##############################################################################
# Azure AI Services                                                           #
##############################################################################

resource "azurerm_ai_services" "main" {
  name                = local.ai_services_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku_name            = "S0"

  tags = var.tags
}

##############################################################################
# Azure AI Foundry Hub                                                        #
##############################################################################

resource "azurerm_ai_foundry" "main" {
  name                = local.ai_foundry_hub_name
  location            = azurerm_ai_services.main.location
  resource_group_name = azurerm_resource_group.main.name
  storage_account_id  = azurerm_storage_account.main.id
  key_vault_id        = azurerm_key_vault.main.id

  application_insights_id = azurerm_application_insights.main.id
  container_registry_id   = azurerm_container_registry.main.id

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  depends_on = [azurerm_key_vault_access_policy.deployer]
}

##############################################################################
# Azure AI Foundry Project                                                    #
##############################################################################

resource "azurerm_ai_foundry_project" "main" {
  name               = local.ai_foundry_project_name
  location           = azurerm_ai_foundry.main.location
  ai_services_hub_id = azurerm_ai_foundry.main.id

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
