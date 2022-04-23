provider tfe {
}

resource "tfe_workspace" "team1-project1" {
  name         = "team1-project1"
  organization = file("../03_setup_tfc/temp_data/tfc_org_name")
}



