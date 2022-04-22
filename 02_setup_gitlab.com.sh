#!/bin/sh

tf() {
	cd 02_setup_gitlab.com
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
