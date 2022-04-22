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

data "vault_aws_access_credentials" "creds" {
  backend = var.vault_aws_secret_backend_aws_path
  role    = var.vault_aws_secret_backend_role_name
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

