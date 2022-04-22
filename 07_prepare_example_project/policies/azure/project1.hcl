# Policy name: myproject
#
# Read-only permission on 'secret/data/myproject/*' path
path "secret/data/myproject/*" {
  capabilities = [ "read" ]
}
path "auth/token/create" {
  capabilities = [ "update" ]
}
path "azure/creds/myproject" {
  capabilities = [ "read" ]
}
path "terraform/creds/team-myproject" {
  capabilities = [ "read" ]
}
path "azure/*" {
  capabilities = [ "read", "list" ]
}
