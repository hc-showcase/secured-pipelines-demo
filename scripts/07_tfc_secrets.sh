#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root
vault secrets disable terraform
vault secrets enable terraform
export TFC_API_TOKEN=`cat tfc_user_api_token`
export TFC_TEAM_ID=`cat tfc_team_id`
vault write terraform/config token=$TFC_API_TOKEN
vault write terraform/role/team-myproject team_id="${TFC_TEAM_ID}" ttl="1h" max_ttl="1h"
export TFC_TOKEN=$(vault read terraform/creds/team-myproject -format=json | jq -r ".data.token")
echo $TFC_TOKEN

export TFC_TEAM_ID2=`cat tfc_team_id2`
vault write terraform/role/team-myproject2 team_id="${TFC_TEAM_ID2}" ttl="1h" max_ttl="1h"
export TFC_TOKEN2=$(vault read terraform/creds/team-myproject2 -format=json | jq -r ".data.token")
echo $TFC_TOKEN2