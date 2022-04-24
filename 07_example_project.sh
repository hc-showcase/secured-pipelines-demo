#!/bin/sh

tf() {
	cd 07_example_project
	terraform init
	terraform apply --auto-approve
}

cmd() {
	vault list sys/leases/lookup/terraform/creds/secured-pipeline-project1
	echo
	vault list sys/leases/lookup/aws/creds/aws-role
}

case $1 in
tf)
	tf
	;;
cmd)
	cmd
	;;
cleanup)
	cd 07_example_project
	terraform destroy
	;;
*)
	echo "cmd for command line, tf for terraform"
	;;
esac
