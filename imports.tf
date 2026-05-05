# Terraform 1.5+ import blocks — run `terraform plan` after `terraform init`
# to verify each resource matches the live configuration.

import {
  to = azurerm_user_assigned_identity.ai_managed_identity
  id = "/subscriptions/74beb7e5-9547-4a02-a2c2-68d4b3804ebf/resourceGroups/AI-100/providers/Microsoft.ManagedIdentity/userAssignedIdentities/AIManagedIdentity"
}

import {
  to = azurerm_ai_services.aids_foundry_dev
  id = "/subscriptions/74beb7e5-9547-4a02-a2c2-68d4b3804ebf/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev"
}

import {
  to = azapi_resource.aids_foundry_dev_proj_bu1
  id = "/subscriptions/74beb7e5-9547-4a02-a2c2-68d4b3804ebf/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/projects/proj-BU1"
}

import {
  to = azapi_resource.aids_foundry_dev_proj_bu2
  id = "/subscriptions/74beb7e5-9547-4a02-a2c2-68d4b3804ebf/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/projects/Proj-BU2"
}

import {
  to = azapi_resource.o4_mini_1
  id = "/subscriptions/74beb7e5-9547-4a02-a2c2-68d4b3804ebf/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/deployments/o4-mini-1"
}

import {
  to = azapi_resource.gpt_4o_1
  id = "/subscriptions/74beb7e5-9547-4a02-a2c2-68d4b3804ebf/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/deployments/gpt-4o-1"
}

import {
  to = azapi_resource.text_embedding_3_small
  id = "/subscriptions/74beb7e5-9547-4a02-a2c2-68d4b3804ebf/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/deployments/text-embedding-3-small"
}
