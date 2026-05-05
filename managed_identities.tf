resource "azurerm_user_assigned_identity" "ai_managed_identity" {
  name                = "AIManagedIdentity"
  resource_group_name = data.azurerm_resource_group.ai_100.name
  location            = "eastus"
}
