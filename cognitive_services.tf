resource "azurerm_ai_services" "aids_foundry_dev" {
  name                  = "Aids-Foundry-Dev"
  location              = "eastus"
  resource_group_name   = data.azurerm_resource_group.ai_100.name
  sku_name              = "S0"
  custom_subdomain_name = "aids-foundry-dev"

  public_network_access = "Enabled"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.ai_managed_identity.id]
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = {}
}
