#!/bin/sh

. 99_source_temp_data.sh

vault secrets disable terraform
vault secrets enable terraform

export TFC_API_TOKEN=`cat tfc_user_api_token`

vault write terraform/config token=$TFC_API_TOKEN
vault write terraform/role/team1-project1 team_id="${TFC_TEAM1_ID}" ttl="1h" max_ttl="1h"
export TFC_TOKEN=$(vault read terraform/creds/team1-project1 -format=json | jq -r ".data.token")
echo $TFC_TOKEN

vault write terraform/role/team2-project1 team_id="${TFC_TEAM2_ID}" ttl="1h" max_ttl="1h"
export TFC_TOKEN2=$(vault read terraform/creds/team-myproject2 -format=json | jq -r ".data.token")
echo $TFC_TOKEN2
