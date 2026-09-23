module "instance" {
  source = "./modules/instance"

  create_instance = var.create_instance
  project_id      = var.project_id
  region          = var.region
  name            = var.name
  mongodb_version = var.mongodb_version
  acl             = var.acl
  flavor          = var.flavor
  replicas        = var.replicas
  storage         = var.storage
  options         = var.options
  backup_schedule = var.backup_schedule
}

module "user" {
  source = "./modules/user"

  project_id  = var.project_id
  region      = var.region
  instance_id = coalesce(module.instance.instance_id, var.instance_id)
  users       = var.users
}
