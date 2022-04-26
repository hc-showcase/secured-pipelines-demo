variable "vault_azure_secret_backend_path" {}
variable "vault_azure_secret_backend_role" {}
variable "gitlab_jwt_token" {}
variable "gitlab_jwt_role" {}
variable "arm_subscription_id" {}
variable "arm_tenant_id" {}
variable "vault_addr" {}
variable "vault_namespace" {}

terraform {
    backend "remote" {}
}

provider "vault" {
  address = var.vault_addr
  auth_login {
    path = "auth/jwt/login"
    namespace = var.vault_namespace
    parameters = {
      jwt   = var.gitlab_jwt_token
      role  = var.gitlab_jwt_role
    }
  }
}

data "vault_azure_access_credentials" "creds" {
  backend                     = var.vault_azure_secret_backend_path
  role                        = var.vault_azure_secret_backend_role
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
