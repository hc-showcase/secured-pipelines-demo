# TFE_TOKEN set as environment variable
provider "tfe" {
}

# Using an existing org as this is TFC; can be replaced with code to create an org if TFE is being used.
data "tfe_organization" "mkaesz-dev" {
  name = "mkaesz-dev"
}

resource "tfe_team" "secured-pipeline-project1" {
  name         = "secured-pipeline-project1"
  organization = data.tfe_organization.mkaesz-dev.name
  visibility   = "secret"
  organization_access {
    manage_vcs_settings = false
    manage_policies     = false
    manage_workspaces   = false
  }
}

resource "tfe_team" "team2" {
  name         = "team2"
  organization = data.tfe_organization.mkaesz-dev.name
}

resource "local_file" "secured-pipeline-project1_id" {
    content  = tfe_team.secured-pipeline-project1.id
    filename = "temp_data/tfc_secured-pipeline-project1_id"
}

resource "local_file" "tfc_team2_id" {
    content  = tfe_team.team2.id
    filename = "temp_data/tfc_team2_id"
}

resource "local_file" "org" {
    content  = data.tfe_organization.mkaesz-dev.name
    filename = "temp_data/tfc_org_name"
}

