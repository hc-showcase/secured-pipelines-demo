#!/bin/sh

tf() {
	cd 07_example_project
	terraform init
	terraform apply --auto-approve
}

cmd() {
	vault write terraform/role/secured-pipeline-project1 user_id="${tfc_user_id}" ttl="1h" max_ttl="1h"
	TFC_TOKEN=$(vault read terraform/creds/secure-pipeline-project1 -format=json | jq -r ".data.token")

	echo
	vault list sys/leases/lookup/terraform/creds/
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
