provider tfe {
}

resource "tfe_team" "secured-pipeline-project" {
  name         = var.project_name
  organization = var.tfe_organization
  visibility   = "secret"
  organization_access {
    manage_vcs_settings = false
    manage_policies     = false
    manage_workspaces   = false
  }
}

resource "tfe_workspace" "secured-pipeline-project" {
  name                          = var.project_name
  organization                  = var.tfe_organization
  structured_run_output_enabled = false
}

resource "tfe_team_access" "secured-pipeline-project" {
  access       = "write"
  team_id      = tfe_team.secured-pipeline-project.id
  workspace_id = tfe_workspace.secured-pipeline-project.id
}
