terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
    }
  }
}

provider "gitlab" {
}

resource "gitlab_project" "secured-pipeline-project1" {
  name        = "secured-pipeline-project1"
  description = "secured-pipeline-project1"

  visibility_level = "public"
}

resource "gitlab_project_variable" "vault_addr" {
  project   = gitlab_project.secured-pipeline-project1.id
  key       = "VAULT_ADDR"
  value     = file(../01_setup_vault/temp_data/vault_public_endpoint_url)
  protected = false
}
