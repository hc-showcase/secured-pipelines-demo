#!/bin/sh

tf() {
	cd 03_setup_tfc
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
*)
	echo "cmd for command line, tf for terraform"
	;;
esac
