resource "azapi_resource" "o4_mini_1" {
  type      = "Microsoft.CognitiveServices/accounts/deployments@2024-10-01"
  name      = "o4-mini-1"
  parent_id = azurerm_ai_services.aids_foundry_dev.id

  body = {
    sku = {
      name     = "GlobalStandard"
      capacity = 500
    }
    properties = {
      model = {
        format  = "OpenAI"
        name    = "o4-mini"
        version = "2025-04-16"
      }
      versionUpgradeOption = "OnceNewDefaultVersionAvailable"
    }
  }
}

resource "azapi_resource" "gpt_4o_1" {
  type      = "Microsoft.CognitiveServices/accounts/deployments@2024-10-01"
  name      = "gpt-4o-1"
  parent_id = azurerm_ai_services.aids_foundry_dev.id

  body = {
    sku = {
      name     = "GlobalStandard"
      capacity = 225
    }
    properties = {
      model = {
        format  = "OpenAI"
        name    = "gpt-4o"
        version = "2024-11-20"
      }
      versionUpgradeOption = "OnceNewDefaultVersionAvailable"
    }
  }
}

resource "azapi_resource" "text_embedding_3_small" {
  type      = "Microsoft.CognitiveServices/accounts/deployments@2024-10-01"
  name      = "text-embedding-3-small"
  parent_id = azurerm_ai_services.aids_foundry_dev.id

  body = {
    sku = {
      name     = "Standard"
      capacity = 120
    }
    properties = {
      model = {
        format  = "OpenAI"
        name    = "text-embedding-3-small"
        version = "1"
      }
      versionUpgradeOption = "OnceNewDefaultVersionAvailable"
    }
  }
}
