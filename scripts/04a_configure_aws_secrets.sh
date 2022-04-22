#!/bin/sh

. 99_source_temp_data.sh

tf() {
	cd 04a_configure_aws_secrets
	terraform init
	terraform apply --auto-approve
}

cmd() {
	vault secrets enable aws
	vault write aws/config/root \
		access_key=$AWS_ACCESS_KEY_ID
	secret_key=$AWS_SECRET_ACCESS_KEY \
		region=eu-central-1

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
