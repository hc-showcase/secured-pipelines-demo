provider tfe {
}

resource "tfe_team" "secured-pipeline-project1" {
  name         = "secured-pipeline-project1"
  organization = file("../03_setup_tfc/temp_data/tfc_org_name")
  visibility   = "secret"
  organization_access {
    manage_vcs_settings = false
    manage_policies     = false
    manage_workspaces   = false
  }
}

resource "tfe_workspace" "secured-pipeline-project1" {
  name         = "secured-pipeline-project1"
  organization = file("../03_setup_tfc/temp_data/tfc_org_name")
  structured_run_output_enabled = false
}

resource "tfe_team_access" "secured-pipeline-project1" {
  access       = "write"
  team_id      = tfe_team.secured-pipeline-project1.id
  workspace_id = tfe_workspace.secured-pipeline-project1.id
}
