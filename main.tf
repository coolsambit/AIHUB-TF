terraform {
  required_version = ">= 1.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

provider "azapi" {}

data "azurerm_resource_group" "ai_100" {
  name = var.resource_group_name
}

data "azurerm_api_management" "ai_gateway" {
  name                = "aigatewayaids"
  resource_group_name = "AI-102"
}
