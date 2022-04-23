provider vault {
}

resource "vault_terraform_cloud_secret_backend" "terraform" {
  backend     = "terraform"
  description = "Manages the Terraform Cloud backend"
  token       = var.tfc_user_token 
}

resource "vault_terraform_cloud_secret_role" "terraform" {
  backend      = vault_terraform_cloud_secret_backend.terraform.backend
  name         = "secured-pipeline-project1"
  team_id      = file("../03_setup_tfc/temp_data/tfc_secured-pipeline-project1_id")
}
