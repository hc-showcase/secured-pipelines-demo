provider vault {
} 

resource "vault_policy" "secured-pipeline-project" {
  name = var.project_name

  policy = <<EOT
path "auth/token/create" {
  capabilities = [ "update" ]
}
path "aws/creds/${var.project_name}" {
  capabilities = [ "read" ]
}
path "terraform/creds/${var.project_name}" {
  capabilities = [ "read" ]
}
path "aws/*" {
  capabilities = [ "read", "list" ]
}
EOT
}

resource "vault_jwt_auth_backend_role" "jwt_auth" {
  backend         = file("../06_configure_vault_gitlab_jwt_auth/temp_data/vault_jwt_auth_path")
  role_name       = gitlab_project.secured-pipeline-project.name
  token_policies  = [gitlab_project.secured-pipeline-project.name]

  bound_claims = {
    "project_id": gitlab_project.secured-pipeline-project.id,
    "ref": "main",
    "ref_type": "branch"
  }
  user_claim      = "user_email"
  role_type       = "jwt"
}

resource "vault_terraform_cloud_secret_role" "terraform" {
  backend      = "terraform"
  name         = var.project_name
  team_id      = tfe_team.secured-pipeline-project.id
}

resource "local_file" "vault_jwt_auth_role" {
    content  = vault_jwt_auth_backend_role.jwt_auth.role_name
    filename = "temp_data/vault_jwt_auth_role"
}
