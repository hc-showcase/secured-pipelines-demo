#!/bin/sh

. 99_source_temp_data.sh

if [ -z "$GOOGLE_APPLICATION_CREDENTIALS" ]
then
    echo "\$GOOGLE_APPLICATION_CREDENTIALS must be set." >&2
	exit -1
fi

tf() {
	cd 04c_configure_gcp_secrets
	terraform init
	terraform apply --auto-approve
}

case $1 in
tf)
	tf
	;;
cleanup)
	cd 04c_configure_gcp_secrets
	terraform destroy
	;;
*)
	echo "cleanup for destroy, tf for terraform"
	;;
esac
