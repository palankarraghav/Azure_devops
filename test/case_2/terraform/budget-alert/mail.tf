locals {
  budget_amounts = {
    dev  = 200
    nonProd   = 500
    prod = 1000
  }

  current_budget = lookup(local.budget_amounts, var.env, 200)
}


data "azurerm_subscription" "current" {}

resource "azurerm_monitor_action_group" "budget-alert-group" {
  name                = "budget-alert-group"
  resource_group_name = var.management_rsg
  short_name          = "budget_alert"
}

resource "azurerm_consumption_budget_subscription" "budget_alert" {
  name            = "subscription-budget-alert"
  subscription_id = data.azurerm_subscription.current.id

  amount     = local.current_budget
  time_grain = "Monthly"

  time_period {
    start_date = "2025-06-01T00:00:00Z"
    end_date   = "2025-07-01T00:00:00Z"
  }

  filter {
    tag {
      name = "env"
      values = [
        var.env
      ]
    }
  }

  notification {
    enabled   = true
    threshold = 90.0
    operator  = "EqualTo"

    contact_groups = [
      azurerm_monitor_action_group.budget-alert-group.id,
    ]

    contact_roles = [
      "Owner",
      "Contributer"
    ]
  }

  notification {
    enabled        = false
    threshold      = 100.0
    operator       = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = [
      "abc@xy.com",
      "def@xy.com",
    ]
  }
}