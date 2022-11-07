terraform {
  required_version = ">= 0.11"
  
  backend "azurerm" {
    resource_group_name = "homework_part2"
    storage_account_name = "ch2611"
    container_name       = "tfstate-web"
    key                  = "tf/terraform.tfstate-web"

    features{
    }
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "rm" {
  name     = "homework_part3"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "rm" {
  name                = "alex-webapp-terraform-plan"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "rm" {
  name                = "alex-webapp-terraform"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  app_service_plan_id = azurerm_app_service_plan.rm.id
}