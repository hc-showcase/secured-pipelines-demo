# HCP_CLIENT_ID and HCP_CLIENT_SECRET are set as environment variables
provider "hcp" {}

resource "hcp_hvn" "secured_pipelines_vault_hvn" {
  hvn_id         = var.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.region
}

resource "hcp_vault_cluster" "secured_pipelines_hcp_vault" {
  hvn_id     = hcp_hvn.secured_pipelines_vault_hvn.hvn_id
  cluster_id = var.cluster_id
  tier       = var.tier
  public_endpoint = true
}

resource "hcp_vault_cluster_admin_token" "vault_admin_token" {
  cluster_id = hcp_vault_cluster.secured_pipelines_hcp_vault.cluster_id
}
