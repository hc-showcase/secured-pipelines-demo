provider vault {
} 

resource "vault_policy" "secured-pipeline-project" {
  name = var.project_name

  policy = <<EOT
path "auth/token/create" {
  capabilities = [ "update" ]
}
path "azure/creds/${var.project_name}" {
  capabilities = [ "read" ]
}
path "terraform/creds/${var.project_name}" {
  capabilities = [ "read" ]
}
path "azure/*" {
  capabilities = [ "read", "list" ]
}
EOT
}

resource "vault_jwt_auth_backend_role" "jwt_auth" {
  backend         = file("../../../06_configure_vault_gitlab_jwt_auth/temp_data/vault_jwt_auth_path")
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

resource "vault_azure_secret_backend_role" "azure-role" {
  backend     = file("../../../04b_configure_azure_secrets/temp_data/vault_azure_secret_backend_path")
  role        = gitlab_project.secured-pipeline-project.name
  ttl         = 300
  max_ttl     = 600

   azure_roles {
    role_name = "Contributor"
    scope     =  "/subscriptions/${var.arm_subscription_id}/resourceGroups/rg-mkaesz"
  }

  azure_roles {
    role_name = "Reader"
    scope     =  "/subscriptions/${var.arm_subscription_id}"
  }

  
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
