#!/bin/sh

export VAULT_TOKEN=$(cat 01_setup_vault/temp_data/vault_admin_token)
export VAULT_ADDR=$(cat 01_setup_vault/temp_data/vault_public_endpoint_url)
export VAULT_NAMESPACE=$(cat 01_setup_vault/temp_data/vault_admin_namespace)

