# Policy name: team1-project1
#
# Read-only permission on 'secret/data/team1-project1/*' path
path "secret/data/team1-project1/*" {
  capabilities = [ "read" ]
}
path "auth/token/create" {
  capabilities = [ "update" ]
}
path "azure/creds/team1-project1" {
  capabilities = [ "read" ]
}
path "aws/creds/team1-project1" {
  capabilities = [ "read" ]
}
path "terraform/creds/team1-project1" {
  capabilities = [ "read" ]
}
path "azure/*" {
  capabilities = [ "read", "list" ]
}
path "aws/*" {
  capabilities = [ "read", "list" ]
}

