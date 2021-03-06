terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
    }
  }
}

provider "gitlab" {
}

data "gitlab_group" "secured-pipelines-projects" {
  full_path = "secured-pipeline-projects"
}

resource "gitlab_project" "secured-pipeline-project" {
  name        = var.project_name
  namespace_id = data.gitlab_group.secured-pipelines-projects.id

  visibility_level = "public"
  shared_runners_enabled = true
  auto_devops_deploy_strategy = "manual"
  auto_devops_enabled = false
}

resource "gitlab_project_variable" "vault_addr" {
  project   = gitlab_project.secured-pipeline-project.id
  key       = "VAULT_ADDR"
  value     = file("../../../01_setup_vault/temp_data/vault_public_endpoint_url")
  protected = false
}

resource "gitlab_project_variable" "vault_namespace" {
  project   = gitlab_project.secured-pipeline-project.id
  key       = "VAULT_NAMESPACE"
  value     = file("../../../01_setup_vault/temp_data/vault_admin_namespace")
  protected = false
}

resource "gitlab_project_variable" "tfe_address" {
  project   = gitlab_project.secured-pipeline-project.id
  key       = "TFE_ADDRESS"
  value     = "https://app.terraform.io"
  protected = false
}

resource "gitlab_project_variable" "tfe_org" {
  project   = gitlab_project.secured-pipeline-project.id
  key       = "TFE_ORG"
  value     = file("../../../03_setup_tfc/temp_data/tfc_org_name")
  protected = false
}

resource "gitlab_project_variable" "tfe_workspace_name" {
  project   = gitlab_project.secured-pipeline-project.id
  key       = "TFE_WS_NAME"
  value     = tfe_workspace.secured-pipeline-project.name
  protected = false
}

resource "gitlab_project_variable" "vault_aws_secret_backend_path" {
  project      = gitlab_project.secured-pipeline-project.id
  key          = "vault_aws_secret_backend_path"
  value        = file("../../../04a_configure_aws_secrets/temp_data/vault_aws_secret_backend_path")
  protected    = false
}

resource "gitlab_project_variable" "vault_aws_secret_backend_role" {
  project      = gitlab_project.secured-pipeline-project.id
  key          = "vault_aws_secret_backend_role"
  value        = vault_aws_secret_backend_role.aws-role.name
  protected    = false
}

resource "gitlab_repository_file" "pipeline" {
  project        = gitlab_project.secured-pipeline-project.id
  content        = file("../projects/${gitlab_project.secured-pipeline-project.name}/gitlab-ci.yml")
  file_path      = ".gitlab-ci.yml"
  branch         = "main"
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "[ci skip] gitlab pipeline descriptor"
}

resource "gitlab_repository_file" "main_tf" {
  project        = gitlab_project.secured-pipeline-project.id
  content        = file("../projects/${gitlab_project.secured-pipeline-project.name}/main.tf")
  file_path      = "main.tf"
  branch         = "main"
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "[ci skip] main.tf"
}
