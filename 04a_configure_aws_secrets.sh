#!/bin/sh

. 99_source_temp_data.sh

tf() {
	cd 04a_configure_aws_secrets
	terraform init
	terraform apply --auto-approve
}

cmd() {
	vault read aws/config/root 
}

case $1 in
tf)
	tf
	;;
cmd)
	cmd
	;;
cleanup)
	cd 04a_configure_aws_secre
	terraform destroy
	;;
*)
	echo "cmd for command line, tf for terraform"
	;;
esac
