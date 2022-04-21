#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root
vault auth disable jwt

vault auth enable jwt

vault policy write myproject - <<EOF
# Policy name: myproject
#
# Read-only permission on 'secret/data/myproject/*' path
path "secret/data/myproject/*" {
  capabilities = [ "read" ]
}
path "auth/token/create" {
  capabilities = [ "update" ]
}
path "azure/creds/myproject" {
  capabilities = [ "read" ]
}
path "terraform/creds/team-myproject" {
  capabilities = [ "read" ]
}
path "azure/*" {
  capabilities = [ "read", "list" ]
}
EOF

vault write auth/jwt/role/myproject - <<EOF
{
  "role_type": "jwt",
  "policies": ["myproject"],
  "token_explicit_max_ttl": 300,
  "user_claim": "user_email",
  "bound_claims": {
    "project_id": "27482646",
    "ref": "main",
    "ref_type": "branch"
  }
}
EOF

vault policy write myproject2 - <<EOF
# Policy name: myproject2
#
# Read-only permission on 'secret/data/myproject/*' path
path "secret/data/myproject2/*" {
  capabilities = [ "read" ]
}
path "auth/token/create" {
  capabilities = [ "update" ]
}
path "azure/creds/myproject2" {
  capabilities = [ "read" ]
}
path "terraform/creds/team-myproject2" {
  capabilities = [ "read" ]
}
path "azure/*" {
  capabilities = [ "read", "list" ]
}
EOF

vault write auth/jwt/role/myproject2 - <<EOF
{
  "role_type": "jwt",
  "policies": ["myproject2"],
  "token_explicit_max_ttl": 300,
  "user_claim": "user_email",
  "bound_claims": {
    "project_id": "28242030",
    "ref": "main",
    "ref_type": "branch"
  }
}
EOF

vault write auth/jwt/config \
    jwks_url="https://gitlab.com/-/jwks" \
    bound_issuer="gitlab.com"

vault read auth/jwt/config
vault read auth/jwt/role/myproject
vault read auth/jwt/role/myproject2
