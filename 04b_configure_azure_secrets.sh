#!/bin/sh

. 99_source_temp_data.sh

tf() {
	cd 04b_configure_azure_secrets
	terraform init
	terraform apply --auto-approve
}

cmd() {
	vault secrets disable azure
	vault secrets enable azure
	source azure_creds
	echo $ARM_CLIENT_ID
	vault write azure/config \
		subscription_id=$ARM_SUBSCRIPTION_ID \
		tenant_id=$ARM_TENANT_ID \
		client_id=$ARM_CLIENT_ID \
		client_secret=$ARM_CLIENT_SECRET

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
