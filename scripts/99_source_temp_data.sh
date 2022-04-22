#!/bin/sh

export VAULT_TOKEN=$(cat 01_setup_vault/temp_data/vault_admin_token)
export VAULT_ADDR=$(cat 01_setup_vault/temp_data/vault_public_endpoint_url)
export VAULT_NAMESPACE=$(cat 01_setup_vault/temp_data/vault_admin_namespace)

export TFC_TEAM1_ID=$(cat 03_setup_tfc/temp_data/tfc_team1_id)
export TFC_TEAM2_ID=$(cat 03_setup_tfc/temp_data/tfc_team2_id)

export TFC_USER_TOKEN=$TFC_SECURED_PIPELINE_DEMO
export TF_VAR_tfc_user_token=$TFC_USER_TOKEN

export TF_VAR_aws_secret_key=$AWS_SECRET_ACCESS_KEY
export TF_VAR_aws_access_key=$AWS_ACCESS_KEY_ID
