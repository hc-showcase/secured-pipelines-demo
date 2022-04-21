provider "gitlab" {
}

resource "gitlab_project" "secured-pipelines" {
  name                   = "secured-pipelines"
  initialize_with_readme = false
  
}


