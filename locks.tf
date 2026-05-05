resource "azurerm_management_lock" "ai_100_lock" {
  name       = "ai-100-delete-lock"
  scope      = data.azurerm_resource_group.ai_100.id
  lock_level = "CanNotDelete"
  notes      = "Protect AI Foundry resources from accidental deletion. Remove this lock before running terraform destroy."
}
