provider vault {
} 

resource "vault_jwt_auth_backend" "jwt_auth" {
    description         = "JWT auth backend for Gitlab"
    path                = "jwt"
    jwks_url            = "https://gitlab.com/-/jwks"
    bound_issuer        = "gitlab.com"
}

resource "vault_jwt_auth_backend_role" "jwt_auth" {
  backend         = vault_jwt_auth_backend.jwt_auth.path
  role_name       = "myproject"
  token_policies  = ["myproject"]

  bound_claims = {
    "project_id": "27482646",
    "ref": "main",
    "ref_type": "branch"
  }
  user_claim      = "user_email"
  role_type       = "jwt"
}
