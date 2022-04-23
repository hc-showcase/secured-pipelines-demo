provider tfe {
}

resource "tfe_workspace" "secured-pipeline-project1" {
  name         = "secured-pipeline-project1"
  organization = file("../03_setup_tfc/temp_data/tfc_org_name")
  structured_run_output_enabled = false
}

resource "tfe_team_access" "secured-pipeline-project1" {
  access       = "write"
  team_id      = file("../03_setup_tfc/temp_data/tfc_secured-pipeline-project1_id")
  workspace_id = tfe_workspace.secured-pipeline-project1.id
}
