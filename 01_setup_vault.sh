#!/bin/sh

tf() {
	cd 01_setup_vault
	terraform init
	terraform apply --auto-approve
	cd ..
	token
}

token() {
	token=$(cat 01_setup_vault/temp_data/vault_admin_token)
#	set -U -x VAULT_TOKEN $token 
	echo $token
}

cmd() {
	echo
}

case $1 in
tf)
	tf
	;;
cmd)
	cmd
	;;
token)
	token
	;;
cleanup)
	cd 01_setup_vault
	terraform destroy
	;;
*)
	echo "cmd for command line, tf for terraform"
	;;
esac
