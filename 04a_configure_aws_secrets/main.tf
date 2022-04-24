provider "vault" {}

resource "vault_aws_secret_backend" "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  path       = "aws"
  description = "The AWS secrets backend used to generate dynamic credentials."
  region = "eu-central-1"

  default_lease_ttl_seconds = "120"
  max_lease_ttl_seconds     = "240"
}
