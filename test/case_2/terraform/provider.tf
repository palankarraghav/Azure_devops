terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.36.0"
    }
  }
  required_version = "1.12.2"
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}