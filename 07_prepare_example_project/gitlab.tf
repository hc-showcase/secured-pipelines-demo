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
  value     = file("../01_setup_vault/temp_data/vault_public_endpoint_url")
  protected = false
}

resource "gitlab_project_variable" "vault_namespace" {
  project   = gitlab_project.secured-pipeline-project1.id
  key       = "VAULT_NAMESPACE"
  value     = file("../01_setup_vault/temp_data/vault_admin_namespace")
  protected = false
}

resource "gitlab_project_variable" "tfc_url" {
  project   = gitlab_project.secured-pipeline-project1.id
  key       = "TFC_URL"
  value     = "https://app.terraform.io/"
  protected = false
}

resource "gitlab_project_variable" "tfc_org" {
  project   = gitlab_project.secured-pipeline-project1.id
  key       = "TFC_ORG"
  value     = file("../03_setup_tfc/temp_data/tfc_org_name")
  protected = false
}

resource "gitlab_project_variable" "tfc_workspace" {
  project   = gitlab_project.secured-pipeline-project1.id
  key       = "TFC_WS"
  value     = tfe_workspace.team1-project1.name
  protected = false
}

resource "gitlab_repository_file" "this" {
  project        = gitlab_project.secured-pipeline-project1.id
  content        = file("example-project/.gitlab-ci.yml")
  file_path      = ".gitlab-ci.yml"
  branch         = "main"
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "added gitlab pipeline descriptor"
}
