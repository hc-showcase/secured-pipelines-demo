#!/bin/sh

VAULT_TOKEN=$(cat 01_setup_vault/temp_data/vault_admin_token)
VAULT_ADDR=$(cat 01_setup_vault/temp_data/vault_public_endpoint_url)
VAULT_NAMESPACE=$(cat 01_setup_vault/temp_data/vault_admin_namespace)

TFC_TEAM1_ID=$(cat 03_setup_tfc/temp_data/tfc_team1_id)
TFC_TEAM2_ID=$(cat 03_setup_tfc/temp_data/tfc_team2_id)

TFC_USER_TOKEN=$TFC_SECURED_PIPELINE_DEMO
