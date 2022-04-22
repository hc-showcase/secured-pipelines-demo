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
path "terraform/creds/team1-secured-pipeline-project1" {
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
  backend         = vault_jwt_auth_backend.jwt_auth.path
  role_name       = gitlab_project.secured-pipeline-project1.name
  token_policies  = ["gitlab_project.secured-pipeline-project1.name"]

  bound_claims = {
    "project_id": "gitlab_project.secured-pipeline-project1.id",
    "ref": "main",
    "ref_type": "branch"
  }
  user_claim      = "user_email"
  role_type       = "jwt"
}

vault write terraform/role/team1-project1 user_id="${tfc_user_id}" ttl="1h" max_ttl="1h"
+  10         TFC_TEAM1_TOKEN=$(vault read terraform/creds/team1-project1 -format=json | jq -r ".data.token")

kkA

resource "vault_terraform_cloud_secret_role" "secured-pipeline-project1.id" {
  backend      = "terraform"
  name         = "team1-project1"
  organization = "mkaesz-dev"
  team_id      = file
}
