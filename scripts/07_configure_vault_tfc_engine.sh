#!/bin/sh

. 99_source_temp_data.sh

tfc_user_id=$(curl -s \
         --header "Authorization: Bearer $TFC_SECURED_PIPELINE_DEMO" \
         --header "Content-Type: application/vnd.api+json" \
         --request GET \
         https://app.terraform.io/api/v2/account/details | jq -r ".data.id")

vault secrets disable terraform
vault secrets enable terraform

vault write terraform/config token=$TFC_SECURED_PIPELINE_DEMO
vault write terraform/role/team1-project1 user_id="${tfc_user_id}" ttl="1h" max_ttl="1h"
TFC_TEAM1_TOKEN=$(vault read terraform/creds/team1-project1 -format=json | jq -r ".data.token")

vault write terraform/role/team2-project1 user_id="${tfc_user_id}" ttl="1h" max_ttl="1h"
TFC_TEAM2_TOKEN=$(vault read terraform/creds/team2-project1 -format=json | jq -r ".data.token")

echo
vault list sys/leases/lookup/terraform/creds/
