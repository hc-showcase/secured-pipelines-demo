terraform {
  required_version = ">= 0.12.0"
}

provider "vault" {
  address = "http://vault:8200"
  auth_login {
    path = "auth/jwt/login"

    parameters = {
      jwt   = var.GITLAB_JWT_TOKEN
      role  = var.GITLAB_JWT_ROLE
    }
  }
}

data "vault_azure_access_credentials" "creds" {
  backend                     = "azure"
  role                        = "myproject"
  validate_creds              = true
  num_sequential_successes    = 8
  num_seconds_between_tests   = 7
  max_cred_validation_seconds = 1200 // 20 minutes
}


provider "azurerm" {
  features {}
  tenant_id = var.ARM_TENANT_ID
  subscription_id = var.ARM_SUBSCRIPTION_ID
  client_id = data.vault_azure_access_credentials.creds.client_id
  client_secret = data.vault_azure_access_credentials.creds.client_secret
}

/*resource "azurerm_virtual_network" "example" {
  name                = "gitlab-network"
  resource_group_name = "kapil-arora"
  location            = "WestEurope"
  address_space       = ["10.0.0.0/16"]
  tags = {
    pipeline = "gitlab"
  }
}*/

output "hello_world" {
  value = "Hello, World!"
}
