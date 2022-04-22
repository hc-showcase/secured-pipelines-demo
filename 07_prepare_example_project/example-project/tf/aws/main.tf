terraform {
    backend "remote" {}
}

provider "aws" {
  region     = "eu-central-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

output "hello_world" {
  value = "Hello, World!"
}

