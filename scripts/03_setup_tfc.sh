#!/bin/sh

tf() {
	cd 03_setup_tfc
	terraform init
	terraform apply
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
