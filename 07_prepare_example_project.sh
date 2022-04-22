#!/bin/sh

tf() {
	cd 07_prepare_example_project
	terraform init
	terraform apply --auto-approve
}

cmd() {
	vault write terraform/role/team1-project1 user_id="${tfc_user_id}" ttl="1h" max_ttl="1h"
	TFC_TEAM1_TOKEN=$(vault read terraform/creds/team1-project1 -format=json | jq -r ".data.token")

	vault write terraform/role/team2-project1 user_id="${tfc_user_id}" ttl="1h" max_ttl="1h"
	TFC_TEAM2_TOKEN=$(vault read terraform/creds/team2-project1 -format=json | jq -r ".data.token")

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
