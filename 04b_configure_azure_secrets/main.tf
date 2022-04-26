resource "vault_azure_secret_backend" "azure" {
  use_microsoft_graph_api = true
  subscription_id         = "11111111-2222-3333-4444-111111111111"
  tenant_id               = "11111111-2222-3333-4444-222222222222"
  client_id               = "11111111-2222-3333-4444-333333333333"
  client_secret           = "12345678901234567890"
  environment             = "AzurePublicCloud"
}
