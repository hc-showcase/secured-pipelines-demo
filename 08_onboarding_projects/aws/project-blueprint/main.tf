variable "vault_aws_secret_backend_path" {}
variable "vault_aws_secret_backend_role" {}
variable "vault_addr" {}
variable "vault_namespace" {}
variable "gitlab_jwt_token" {}
variable "gitlab_jwt_role" {}

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

data "vault_aws_access_credentials" "creds" {
  backend = var.vault_aws_secret_backend_path
  role    = var.vault_aws_secret_backend_role
}

provider "aws" {
  region     = "eu-central-1"
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

output "hello_world" {
  value = "Hello, World!"
}

