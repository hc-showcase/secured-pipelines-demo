#!/bin/sh

. 99_source_temp_data.sh

if [ -z "$AWS_SECRET_ACCESS_KEY" ]
then
    echo "\$AWS_SECRET_ACCESS_KEY must be set." >&2
	exit -1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]
then
    echo "\$AWS_ACCESS_KEY_ID must be set." >&2
	exit -1
fi

tf() {
	cd 04a_configure_aws_secrets
	terraform init
	terraform apply --auto-approve
}

case $1 in
tf)
	tf
	;;
cleanup)
	cd 04a_configure_aws_secrets
	terraform destroy
	;;
*)
	echo "cleanup for destroy, tf for terraform"
	;;
esac
