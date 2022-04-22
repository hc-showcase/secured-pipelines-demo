output "vault_admin_token" {
   description = "Admin Token of the HCP Vault Cluster"
   value       = hcp_vault_cluster_admin_token.vault_admin_token.token
   sensitive   = true
}

output "vault_public_endpoint" {
   description = "Public endpoint of Vault cluster"
   value       = hcp_vault_cluster.secured_pipelines_hcp_vault.vault_public_endpoint_url
}

output "vault_admin_namespace" {
   description = "Initial Vault namespace"
   value       = hcp_vault_cluster.secured_pipelines_hcp_vault.namespace
}
