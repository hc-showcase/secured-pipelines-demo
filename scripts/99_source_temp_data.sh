#!/bin/sh

export VAULT_TOKEN=$(cat 01_setup_vault/temp_data/vault_admin_token)
export VAULT_ADDR=$(cat 01_setup_vault/temp_data/vault_public_endpoint_url)
export VAULT_NAMESPACE=$(cat 01_setup_vault/temp_data/vault_admin_namespace)

export TFC_TEAM1_ID=$(cat 03_setup_tfc/temp_data/tfc_team1_id)
export TFC_TEAM1_TOKEN=$(cat 03_setup_tfc/temp_data/tfc_team1_token)
export TFC_TEAM2_ID=$(cat 03_setup_tfc/temp_data/tfc_team2_id)
export TFC_TEAM2_TOKEN=$(cat 03_setup_tfc/temp_data/tfc_team2_token)

