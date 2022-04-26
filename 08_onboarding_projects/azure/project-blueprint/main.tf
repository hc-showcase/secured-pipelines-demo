variable "gitlab_jwt_token" {}
variable "gitlab_jwt_role" {}
variable "arm_subscription_id" {}
variable "arm_tenant_id" {}
variable "vault_addr"

terraform {
    backend "remote" {}
}

provider "vault" {
  address = var.vault_addr
  auth_login {
    path = "auth/jwt/login"

    parameters = {
      jwt   = var.gitlab_jwt_token
      role  = var.gitlab_jwt_role
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
  tenant_id = var.arm_tenant_id
  subscription_id = var.arm_subscription_id
  client_id = data.vault_azure_access_credentials.creds.client_id
  client_secret = data.vault_azure_access_credentials.creds.client_secret
}

resource "azurerm_virtual_network" "example" {
  name                = "nw-mkaesz"
  resource_group_name = "rg-mkaesz"
  location            = "WestEurope"
  address_space       = ["10.0.0.0/16"]
  tags = {
    pipeline = "gitlab"
  }
}

output "hello_world" {
  value = "Hello, World!"
}
