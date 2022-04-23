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

resource "vault_aws_secret_backend_role" "aws-role" {
  backend         = vault_aws_secret_backend.aws.path
  name            = "${var.name}-role"
  credential_type = "iam_user"

  policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:*", "ec2:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "local_file" "vault_aws_secret_backend_path" {
    content  = vault_aws_secret_backend.aws.path
    filename = "temp_data/vault_aws_secret_backend_path"
}

resource "local_file" "vault_aws_secret_backend_role" {
    content  = vault_aws_secret_backend_role.aws-role.name
    filename = "temp_data/vault_aws_secret_backend_role"
}
