data "azurerm_subscription" "current" {}

data "azuread_group" "devops_group" {
  display_name = "${var.env}-DevOps-Team"
}

data "azuread_group" "dev_group" {
  display_name = "${var.env}-Dev-Team"
}

resource "azurerm_role_assignment" "devops_reader" {
  scope                = data.azurerm_subscription.current.subscription_id
  role_definition_name = "Contributer"
  principal_id         = data.azuread_group.devops_group.object_id
}

resource "azurerm_role_assignment" "dev_group" {
  scope                = data.azurerm_subscription.current.subscription_id
  role_definition_name = "Reader"
  principal_id         = data.azuread_group.dev_group.object_id
}