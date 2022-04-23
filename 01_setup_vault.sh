#!/bin/sh

tf() {
	cd 01_setup_vault
	terraform init
	terraform apply --auto-approve
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
cleanup)
	cd 01_setup_vault
	terraform destroy
	;;
*)
	echo "cmd for command line, tf for terraform"
	;;
esac
