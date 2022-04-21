terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
    }
  }
}

provider "gitlab" {
}

resource "gitlab_project" "secured_pipelines" {
  name                   = "secured-pipelines"
  initialize_with_readme = false
}


