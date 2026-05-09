variable "subscription_id" {
  description = "The Azure Subscription ID in which to create resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which all control plane resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where all control plane resources will be created (e.g. 'eastus', 'westeurope')."
  type        = string
  default     = "eastus"
}

variable "prefix" {
  description = "A short prefix used to name all resources (2–8 alphanumeric characters, lowercase)."
  type        = string
  default     = "aihub"

  validation {
    condition     = can(regex("^[a-z0-9]{2,8}$", var.prefix))
    error_message = "prefix must be 2–8 lowercase alphanumeric characters."
  }
}

variable "ai_foundry_hub_name" {
  description = "The name of the Azure AI Foundry Hub. Defaults to '<prefix>-hub'."
  type        = string
  default     = ""
}

variable "ai_foundry_project_name" {
  description = "The name of the Azure AI Foundry Project. Defaults to '<prefix>-project'."
  type        = string
  default     = ""
}

variable "storage_account_name" {
  description = "The name of the Storage Account. Must be globally unique, 3–24 lowercase alphanumeric characters. Defaults to '<prefix>sa<random>'."
  type        = string
  default     = ""
}

variable "key_vault_name" {
  description = "The name of the Key Vault. Must be globally unique, 3–24 alphanumeric characters and hyphens. Defaults to '<prefix>-kv-<random>'."
  type        = string
  default     = ""
}

variable "application_insights_name" {
  description = "The name of the Application Insights instance. Defaults to '<prefix>-appinsights'."
  type        = string
  default     = ""
}

variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics Workspace backing Application Insights. Defaults to '<prefix>-law'."
  type        = string
  default     = ""
}

variable "container_registry_name" {
  description = "The name of the Azure Container Registry. Must be globally unique, 5–50 alphanumeric characters. Defaults to '<prefix>acr<random>'. Set to empty string to skip creation."
  type        = string
  default     = ""
}

variable "ai_services_name" {
  description = "The name of the Azure AI Services multi-service account. Defaults to '<prefix>-aiservices'."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default     = {}
}
