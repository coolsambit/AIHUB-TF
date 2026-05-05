resource "azapi_resource" "aids_foundry_dev_proj_bu1" {
  type      = "Microsoft.CognitiveServices/accounts/projects@2025-10-01-preview"
  name      = "proj-BU1"
  parent_id = azurerm_ai_services.aids_foundry_dev.id
  location  = "eastus"

  identity {
    type = "SystemAssigned"
  }

  body = {
    properties = {
      displayName = "proj-BU1"
      description = "Default project created with the resource"
    }
  }

  lifecycle {
    ignore_changes = [output, identity]
  }
}

resource "azapi_resource" "aids_foundry_dev_proj_bu2" {
  type      = "Microsoft.CognitiveServices/accounts/projects@2025-10-01-preview"
  name      = "Proj-BU2"
  parent_id = azurerm_ai_services.aids_foundry_dev.id
  location  = "eastus"

  identity {
    type = "SystemAssigned"
  }

  body = {
    properties = {
      displayName = "Proj-BU2"
      description = "Projects that are "
    }
  }

  lifecycle {
    ignore_changes = [output, identity]
  }
}
