provider vault {
}

resource "vault_terraform_cloud_secret_backend" "terraform" {
  backend     = "terraform"
  description = "Manages the Terraform Cloud backend"
  token       = var.tfc_user_token 
}

resource "vault_terraform_cloud_secret_role" "terraform" {
  backend      = vault_terraform_cloud_secret_backend.terraform.backend
  name         = "user-token"
  user_id      = var.tfc_user_id
}
