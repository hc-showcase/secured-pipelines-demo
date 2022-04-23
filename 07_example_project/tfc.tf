provider tfe {
}

resource "tfe_workspace" "secured-pipeline-project1" {
  name         = "secured-pipeline-project1"
  organization = file("../03_setup_tfc/temp_data/tfc_org_name")
}
