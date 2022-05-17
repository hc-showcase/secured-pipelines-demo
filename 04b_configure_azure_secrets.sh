#!/bin/sh

. 99_source_temp_data.sh

if [ -z "$ARM_SUBSCRIPTION_ID" ]
then
    echo "\$ARM_SUBSCRIPTION_ID must be set." >&2
	exit -1
fi

if [ -z "$ARM_TENANT_ID" ]
then
    echo "\$ARM_TENANT_ID must be set." >&2
	exit -1
fi

if [ -z "$ARM_CLIENT_ID" ]
then
    echo "\$ARM_CLIENT_ID must be set." >&2
	exit -1
fi

if [ -z "$ARM_CLIENT_SECRET" ]
then
    echo "\$ARM_CLIENT_SECRET must be set." >&2
	exit -1
fi

tf() {
	cd 04b_configure_azure_secrets
	terraform init
	terraform apply --auto-approve
}

cleanup() {
	cd 04b_configure_azure_secrets
	terraform destroy
}

case $1 in
tf)
	tf
	;;
cleanup)
	cleanup
	;;
*)
	echo "cleanup to destroy, tf for terraform"
	;;
esac
