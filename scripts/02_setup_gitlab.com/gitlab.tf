terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
    }
  }
}

# GITLAB_TOKEN set as environment variable
provider "gitlab" {
}

