output "resource_group_name" {
  description = "The name of the Resource Group containing all control plane resources."
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "The ID of the Resource Group containing all control plane resources."
  value       = azurerm_resource_group.main.id
}

output "storage_account_id" {
  description = "The ID of the Storage Account used by the AI Foundry Hub."
  value       = azurerm_storage_account.main.id
}

output "storage_account_name" {
  description = "The name of the Storage Account used by the AI Foundry Hub."
  value       = azurerm_storage_account.main.name
}

output "key_vault_id" {
  description = "The ID of the Key Vault used by the AI Foundry Hub."
  value       = azurerm_key_vault.main.id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault used by the AI Foundry Hub."
  value       = azurerm_key_vault.main.vault_uri
}

output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.main.id
}

output "application_insights_id" {
  description = "The ID of the Application Insights instance."
  value       = azurerm_application_insights.main.id
}

output "application_insights_instrumentation_key" {
  description = "The instrumentation key of the Application Insights instance."
  value       = azurerm_application_insights.main.instrumentation_key
  sensitive   = true
}

output "container_registry_id" {
  description = "The ID of the Azure Container Registry."
  value       = azurerm_container_registry.main.id
}

output "container_registry_login_server" {
  description = "The login server URL of the Azure Container Registry."
  value       = azurerm_container_registry.main.login_server
}

output "ai_services_id" {
  description = "The ID of the Azure AI Services multi-service account."
  value       = azurerm_ai_services.main.id
}

output "ai_foundry_hub_id" {
  description = "The ID of the Azure AI Foundry Hub."
  value       = azurerm_ai_foundry.main.id
}

output "ai_foundry_hub_name" {
  description = "The name of the Azure AI Foundry Hub."
  value       = azurerm_ai_foundry.main.name
}

output "ai_foundry_hub_discovery_url" {
  description = "The discovery URL of the Azure AI Foundry Hub."
  value       = azurerm_ai_foundry.main.discovery_url
}

output "ai_foundry_hub_workspace_id" {
  description = "The immutable workspace ID of the Azure AI Foundry Hub."
  value       = azurerm_ai_foundry.main.workspace_id
}

output "ai_foundry_hub_principal_id" {
  description = "The Principal ID of the system-assigned managed identity of the AI Foundry Hub."
  value       = azurerm_ai_foundry.main.identity[0].principal_id
}

output "ai_foundry_project_id" {
  description = "The ID of the Azure AI Foundry Project."
  value       = azurerm_ai_foundry_project.main.id
}

output "ai_foundry_project_name" {
  description = "The name of the Azure AI Foundry Project."
  value       = azurerm_ai_foundry_project.main.name
}

output "ai_foundry_project_project_id" {
  description = "The immutable project ID of the Azure AI Foundry Project."
  value       = azurerm_ai_foundry_project.main.project_id
}
