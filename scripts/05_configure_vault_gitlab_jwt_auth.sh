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

	echo && vault write auth/jwt/config \
	            jwks_url="https://gitlab.com/-/jwks" \
		    bound_issuer="gitlab.com"

	echo && vault read auth/jwt/config
}

case $1 in
tf)
	tf
	;;
cmd)
	cmd
	;;
*)
	echo "cmd for command line, tf for terraform"
	;;
esac