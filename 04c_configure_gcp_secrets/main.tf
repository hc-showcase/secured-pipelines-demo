variable "google_cloud_credentials" {}

provider "vault" {}

resource "vault_gcp_secret_backend" "gcp" {
  path = "gcp"
  description = "The GCP secrets backend used to generate dynamic credentials."
  credentials = var.google_cloud_credentials
 
  default_lease_ttl_seconds = "120"
  max_lease_ttl_seconds     = "240"
}

resource "local_file" "vault_gcp_secret_backend_path" {
    content  = vault_gcp_secret_backend.gcp.path
    filename = "temp_data/vault_gcp_secret_backend_path"
}
