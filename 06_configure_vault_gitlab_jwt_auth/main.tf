provider vault {
} 

resource "vault_jwt_auth_backend" "jwt_auth" {
    description         = "JWT auth backend for Gitlab"
    path                = "jwt"
    jwks_url            = "https://gitlab.com/-/jwks"
    bound_issuer        = "gitlab.com"
}

resource "local_file" "vault_admin_token" {
    content  = vault_jwt_auth_backend.jwt_auth.path 
    filename = "temp_data/vault_jwt_auth_path"
}
