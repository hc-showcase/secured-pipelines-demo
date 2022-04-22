provider tfe {
}

resource "tfe_workspace" "team1-project1" {
  name         = "team1-project1"
  organization = file("../03_setup_tfc/temp_data/tfc_org_name")
}

resource "tfe_variable" "vault_aws_secret_backend_path" {
  key          = "vault_aws_secret_backend_path"
  value        = file("../04a_configure_aws_secrets/temp_data/vault_aws_secret_backend_path")
  category     = "terraform"
  workspace_id = tfe_workspace.team1-project1.id
  description  = "Vault AWS auth role."
}

resource "tfe_variable" "vault_aws_secret_backend_role" {
  key          = "vault_aws_secret_backend_role"
  value        = file("../04a_configure_aws_secrets/temp_data/vault_aws_secret_backend_role")
  category     = "terraform"
  workspace_id = tfe_workspace.team1-project1.id
  description  = "Vault AWS auth role."
}


