resource "stackit_mongodbflex_instance" "this" {
  count = var.create_instance ? 1 : 0

  project_id      = var.project_id
  region          = var.region
  name            = var.name
  version         = var.mongodb_version
  acl             = var.acl
  replicas        = var.replicas
  backup_schedule = var.backup_schedule

  flavor  = var.flavor
  storage = var.storage
  options = var.options
}
