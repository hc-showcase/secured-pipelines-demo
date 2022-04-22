#!/bin/sh

. 99_source_temp_data.sh

tf() {
	cd 05_configure_vault_tfc_secrets
	terraform init
	terraform apply --auto-approve
}

cmd() {
	vault secrets disable terraform
	vault secrets enable terraform

	vault write terraform/config token=$TFC_SECURED_PIPELINE_DEMO
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
