#!/bin/sh

. 99_source_temp_data.sh

function tf() {
	cd 06_configure_vault_gitlab_jwt_auth
	terraform init
	terraform apply --auto-approve
}

function cmd() {
	vault read auth/jwt/config
}

case $1 in
tf)
	tf
	;;
cmd)
	cmd
	;;
cleanup)
	cd 06_configure_vault_gitlab_jwt_auth
	terraform destroy
	;;
*)
	echo "cmd for command line, tf for terraform"
	;;
esac
