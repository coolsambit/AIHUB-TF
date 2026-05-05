# Terraform 1.7+ import blocks — run `terraform plan` after `terraform init`
# to verify each resource matches the live configuration.

import {
  to = azurerm_user_assigned_identity.ai_managed_identity
  id = "/subscriptions/${var.subscription_id}/resourceGroups/AI-100/providers/Microsoft.ManagedIdentity/userAssignedIdentities/AIManagedIdentity"
}

import {
  to = azurerm_ai_services.aids_foundry_dev
  id = "/subscriptions/${var.subscription_id}/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev"
}

import {
  to = azapi_resource.aids_foundry_dev_proj_bu1
  id = "/subscriptions/${var.subscription_id}/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/projects/proj-BU1"
}

import {
  to = azapi_resource.aids_foundry_dev_proj_bu2
  id = "/subscriptions/${var.subscription_id}/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/projects/Proj-BU2"
}

import {
  to = azapi_resource.o4_mini_1
  id = "/subscriptions/${var.subscription_id}/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/deployments/o4-mini-1"
}

import {
  to = azapi_resource.gpt_4o_1
  id = "/subscriptions/${var.subscription_id}/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/deployments/gpt-4o-1"
}

import {
  to = azapi_resource.text_embedding_3_small
  id = "/subscriptions/${var.subscription_id}/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/deployments/text-embedding-3-small"
}

import {
  to = azapi_resource.proj_bu1_aisearch
  id = "/subscriptions/${var.subscription_id}/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/projects/proj-BU1/connections/aisearch2024h299w2"
}

import {
  to = azapi_resource.proj_bu2_aisearch
  id = "/subscriptions/${var.subscription_id}/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/projects/Proj-BU2/connections/aisearch2024qpuevj"
}

import {
  to = azapi_resource.proj_bu2_github
  id = "/subscriptions/${var.subscription_id}/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/projects/Proj-BU2/connections/GitHub"
}

import {
  to = azapi_resource.proj_bu2_mcp
  id = "/subscriptions/${var.subscription_id}/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/projects/Proj-BU2/connections/FoundryMCPServerpreview"
}
