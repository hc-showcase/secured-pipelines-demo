provider "tfe" {
}

# Using an existing org as this is TFC; can be replaced with code to create an org if TFE is being used.
data "tfe_organization" "mkaesz-dev" {
  name = "mkaesz-dev"
}
