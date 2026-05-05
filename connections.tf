# proj-BU1 connections
resource "azapi_resource" "proj_bu1_aisearch" {
  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-10-01-preview"
  name      = "aisearch2024h299w2"
  parent_id = azapi_resource.aids_foundry_dev_proj_bu1.id

  schema_validation_enabled = false

  body = {
    properties = {
      authType      = "ProjectManagedIdentity"
      category      = "CognitiveSearch"
      isDefault     = false
      isSharedToAll = false
      metadata = {
        ApiType              = "Azure"
        ApiVersion           = "2024-05-01-preview"
        DeploymentApiVersion = "2023-11-01"
        ResourceId           = "/subscriptions/74beb7e5-9547-4a02-a2c2-68d4b3804ebf/resourceGroups/AI-102/providers/Microsoft.Search/searchServices/aisearch-2024"
        displayName          = "aisearch-2024"
        type                 = "azure_ai_search"
      }
      peRequirement               = "NotRequired"
      peStatus                    = "NotApplicable"
      target                      = "https://aisearch-2024.search.windows.net/"
      useWorkspaceManagedIdentity = false
    }
  }
}

# proj-BU2 connections
resource "azapi_resource" "proj_bu2_aisearch" {
  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-10-01-preview"
  name      = "aisearch2024qpuevj"
  parent_id = azapi_resource.aids_foundry_dev_proj_bu2.id

  schema_validation_enabled = false

  body = {
    properties = {
      authType      = "ProjectManagedIdentity"
      category      = "CognitiveSearch"
      isDefault     = true
      isSharedToAll = false
      metadata = {
        ApiType              = "Azure"
        ApiVersion           = "2024-05-01-preview"
        DeploymentApiVersion = "2023-11-01"
        ResourceId           = "/subscriptions/74beb7e5-9547-4a02-a2c2-68d4b3804ebf/resourceGroups/AI-102/providers/Microsoft.Search/searchServices/aisearch-2024"
        displayName          = "aisearch-2024"
        type                 = "azure_ai_search"
      }
      peRequirement               = "NotRequired"
      peStatus                    = "NotApplicable"
      target                      = "https://aisearch-2024.search.windows.net/"
      useWorkspaceManagedIdentity = false
    }
  }
}

resource "azapi_resource" "proj_bu2_github" {
  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-10-01-preview"
  name      = "GitHub"
  parent_id = azapi_resource.aids_foundry_dev_proj_bu2.id

  body = {
    properties = {
      authType      = "CustomKeys"
      category      = "RemoteTool"
      isSharedToAll = false
      metadata = {
        toolEntityId = "azureml://location/eastus/apiCenter/registry-prod-bl/type/tools/objectId/github-mcp-server/version/1"
        type         = "catalog_MCP"
      }
      peRequirement               = "NotRequired"
      peStatus                    = "NotApplicable"
      target                      = "https://aigatewayaids.azure-api.net/tool-Proj-BU2-api-githubcopilot-com-mcp"
      useWorkspaceManagedIdentity = false
    }
  }
}

resource "azapi_resource" "proj_bu2_mcp" {
  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-10-01-preview"
  name      = "FoundryMCPServerpreview"
  parent_id = azapi_resource.aids_foundry_dev_proj_bu2.id

  schema_validation_enabled = false

  body = {
    properties = {
      audience      = "https://mcp.ai.azure.com"
      authType      = "UserEntraToken"
      category      = "RemoteTool"
      isDefault     = false
      isSharedToAll = false
      metadata = {
        toolEntityId = "azureml://location/eastus/apiCenter/registry-prod-bl/type/tools/objectId/microsoft-foundry-mcp-server/version/1"
        type         = "catalog_MCP"
      }
      peRequirement               = "NotRequired"
      peStatus                    = "NotApplicable"
      target                      = "https://mcp.ai.azure.com"
      useWorkspaceManagedIdentity = false
    }
  }
}
