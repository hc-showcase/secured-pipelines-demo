provider vault {
} 

resource "vault_policy" "secured-pipeline-project1" {
  name = "secured-pipeline-project1"

  policy = <<EOT
path "secret/data/secured-pipeline-project1/*" {
  capabilities = [ "read" ]
}
path "auth/token/create" {
  capabilities = [ "update" ]
}
path "azure/creds/secured-pipeline-project1" {
  capabilities = [ "read" ]
}
path "aws/creds/secured-pipeline-project1" {
  capabilities = [ "read" ]
}
path "terraform/creds/secured-pipeline-project1" {
  capabilities = [ "read" ]
}
path "terraform/creds/team1-secured-pipeline-project1" {
  capabilities = [ "read" ]
}
path "terraform/creds/user-token" {
  capabilities = [ "read" ]
}
path "azure/*" {
  capabilities = [ "read", "list" ]
}
path "aws/*" {
  capabilities = [ "read", "list" ]
}
EOT
}

resource "vault_jwt_auth_backend_role" "jwt_auth" {
  backend         = file("../06_configure_vault_gitlab_jwt_auth/temp_data/vault_jwt_auth_path")
  role_name       = gitlab_project.secured-pipeline-project1.name
  token_policies  = [gitlab_project.secured-pipeline-project1.name]

  bound_claims = {
    "project_id": gitlab_project.secured-pipeline-project1.id,
    "ref": "main",
    "ref_type": "branch"
  }
  user_claim      = "user_email"
  role_type       = "jwt"
}
