# Policy name: myproject2
#
# Read-only permission on 'secret/data/myproject/*' path
path "secret/data/myproject2/*" {
  capabilities = [ "read" ]
}
path "auth/token/create" {
  capabilities = [ "update" ]
}
path "azure/creds/myproject2" {
  capabilities = [ "read" ]
}
path "terraform/creds/team-myproject2" {
  capabilities = [ "read" ]
}
path "azure/*" {
  capabilities = [ "read", "list" ]
}
