# TFE_TOKEN set as environment variable
provider "tfe" {
}

# Using an existing org as this is TFC; can be replaced with code to create an org if TFE is being used.
data "tfe_organization" "mkaesz-dev" {
  name = "mkaesz-dev"
}

resource "tfe_team" "team1" {
  name         = "team1"
  organization = data.tfe_organization.mkaesz-dev.name
}

resource "tfe_team" "team2" {
  name         = "team2"
  organization = data.tfe_organization.mkaesz-dev.name
}

resource "local_file" "tfc_team1_id" {
    content  = tfe_team.team1.id
    filename = "temp_data/tfc_team1_id"
}

resource "local_file" "tfc_team2_id" {
    content  = tfe_team.team2.id
    filename = "temp_data/tfc_team2_id"
}
