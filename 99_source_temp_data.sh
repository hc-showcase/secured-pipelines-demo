#!/bin/sh

export VAULT_TOKEN=$(cat 01_setup_vault/temp_data/vault_admin_token)
export VAULT_ADDR=$(cat 01_setup_vault/temp_data/vault_public_endpoint_url)
export VAULT_NAMESPACE=$(cat 01_setup_vault/temp_data/vault_admin_namespace)

export TF_VAR_tfc_user_token=$TFE_USER_TOKEN

export TF_VAR_aws_secret_key=$AWS_SECRET_ACCESS_KEY
export TF_VAR_aws_access_key=$AWS_ACCESS_KEY_ID

export TF_VAR_arm_subscription_id=$ARM_SUBSCRIPTION_ID
export TF_VAR_arm_tenant_id=$ARM_TENANT_ID
export TF_VAR_arm_client_id=$ARM_CLIENT_ID
export TF_VAR_arm_client_secret=$ARM_CLIENT_SECRET
