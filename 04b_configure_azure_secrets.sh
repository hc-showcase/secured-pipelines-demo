#!/bin/sh

. 99_source_temp_data.sh

tf() {
	cd 04b_configure_azure_secrets
	terraform init
	terraform apply --auto-approve
}

cmd() {

	vault write azure/roles/myproject ttl=1h azure_roles=- <<EOF
    [
        {
            "role_name": "Contributor",
            "scope":  "/subscriptions/${ARM_SUBSCRIPTION_ID}/resourceGroups/kapil-arora"
        },
        {
            "role_name": "Reader",
            "scope":  "/subscriptions/${ARM_SUBSCRIPTION_ID}"
        }
    ]
EOF

	vault read azure/creds/myproject

	vault write azure/roles/myproject2 ttl=1h azure_roles=- <<EOF
    [
        {
            "role_name": "Contributor",
            "scope":  "/subscriptions/${ARM_SUBSCRIPTION_ID}/resourceGroups/kapil-arora"
        },
        {
            "role_name": "Reader",
            "scope":  "/subscriptions/${ARM_SUBSCRIPTION_ID}"
        }
    ]
EOF

	vault read azure/creds/myproject2

	vault read azure/config
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
