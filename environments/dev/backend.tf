terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.1.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-ts-terraform"
    storage_account_name = "sttstfbackenddevtest"
    container_name       = "con-ts-tsiac-test"
    key                  = "terraform.tfstate"
  }
  required_version = ">=1.7.4"
}

provider "azurerm" {
  use_oidc = true
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "azapi" {
}
