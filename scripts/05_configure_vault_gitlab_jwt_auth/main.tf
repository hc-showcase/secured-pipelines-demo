provider vault {
} 

resource "vault_jwt_auth_backend" "jwt_auth" {
    description         = "JWT auth backend for Gitlab"
    path                = "jwt"
    jwks_url            = "https://gitlab.com/-/jwks"
    bound_issuer        = "gitlab.com"
}

