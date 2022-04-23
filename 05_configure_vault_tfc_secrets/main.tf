provider vault {
}

resource "vault_terraform_cloud_secret_backend" "terraform" {
  backend     = "terraform"
  description = "Manages the Terraform Cloud backend"
  token       = var.tfc_user_token 
}
