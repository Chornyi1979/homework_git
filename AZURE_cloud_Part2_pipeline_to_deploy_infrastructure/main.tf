# Configure the Azure 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
    backend "azurerm" {
            resource_group_name  = "homework_part2"
            storage_account_name = "alex2611"
            container_name       = "tfstate"
            key                  = "terraform.tfstate"
        }
    
}
provider "azurerm" {
  features {}
}

#Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "homework_part"
  location = "eastus"
}

# Create the Linux App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = "webapp-ch2611_plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Create the web app, pass in the App Service Plan ID
resource "azurerm_linux_web_app" "webapp" {
  name                  = "webapp-ch2611"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  service_plan_id       = azurerm_service_plan.appserviceplan.id
  https_only            = true
  site_config { 
    minimum_tls_version = "1.2"
  }
}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.webapp.id
  repo_url           = "https://alex2611@dev.azure.com/alex2611/alex-ui-test/_git/homework_part2"
  branch             = "main"
  use_manual_integration = true
  use_mercurial      = false
}
