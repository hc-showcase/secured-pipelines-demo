#!/bin/sh

. 99_source_temp_data.sh

user_id=$(curl -s \
    --header "Authorization: Bearer $TFE_USER_TOKEN" \
    --header "Content-Type: application/vnd.api+json" \
    --request GET \
    https://app.terraform.io/api/v2/account/details | jq -r ".data.id")

export TF_VAR_tfc_user_id=$user_id

tf() {
	cd 05_configure_vault_tfc_secrets
	terraform init
	terraform apply --auto-approve
}

cmd() {
	vault read terraform/config
}

case $1 in
tf)
	tf
	;;
cmd)
	cmd
	;;
cleanup)
	cd 05_configure_vault_tfc_secrets
	terraform destroy
	;;
*)
	echo "cmd for command line, tf for terraform"
	;;
esac
