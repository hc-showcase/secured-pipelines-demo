#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

source azure_creds
vault kv put secret/myproject/tfc \
ws=gitlab-vault-tfc-api-driven \
org=kapil-org \
addr=app.terraform.io \
ARM_TENANT_ID=${ARM_TENANT_ID} \
ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID}

vault kv put secret/myproject2/tfc \
ws=gitlab-vault-tfc-api-driven2 \
org=kapil-org \
addr=app.terraform.io \
ARM_TENANT_ID=${ARM_TENANT_ID} \
ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID}

vault kv get -field=ws secret/myproject/tfc
vault kv get -field=org secret/myproject/tfc
vault kv get -field=addr secret/myproject/tfc
vault kv get -field=ARM_TENANT_ID secret/myproject/tfc
vault kv get -field=ARM_SUBSCRIPTION_ID secret/myproject/tfc


vault kv get -field=ws secret/myproject2/tfc
vault kv get -field=org secret/myproject2/tfc
vault kv get -field=addr secret/myproject2/tfc
vault kv get -field=ARM_TENANT_ID secret/myproject2/tfc
vault kv get -field=ARM_SUBSCRIPTION_ID secret/myproject2/tfc

