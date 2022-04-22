#!/bin/sh

. 99_source_temp_data.sh

function tf() {
	cd 05_configure_vault_jwt_auth
	terraform init
	terraform apply --auto-approve
}

function cmd() {
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

echo
vault read auth/jwt/config
echo
vault read auth/jwt/role/myproject
echo
vault read auth/jwt/role/myproject2
}

case $1 in
	tf)
		tf;;
	cmd)
		cmd;;
	*)
		echo "cmd for command line, tf for terraform";;
esac
