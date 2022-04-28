variable "arm_subscription_id" {}
variable "arm_tenant_id" {}
variable "arm_client_id" {}
variable "arm_client_secret" {}

provider "vault" {}

resource "vault_azure_secret_backend" "azure" {
  path			  = "azure"
  use_microsoft_graph_api = false
  subscription_id         = var.arm_subscription_id
  tenant_id               = var.arm_tenant_id
  client_id               = var.arm_client_id
  client_secret           = var.arm_client_secret
  environment             = "AzurePublicCloud"
}

resource "local_file" "vault_azure_secret_backend_path" {
    content  = vault_azure_secret_backend.azure.path
    filename = "temp_data/vault_azure_secret_backend_path"
}
