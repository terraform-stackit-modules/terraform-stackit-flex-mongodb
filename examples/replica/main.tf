#####################################################################################
# "replica" example — self-contained, requires only `project_id`.
#
# High-availability MongoDB Flex REPLICA SET. Unlike the SQL Flex engines (where
# replication is carried by the plan/flavor), MongoDB Flex exposes replication
# natively: options.type = "Replica" with replicas = 3.
#####################################################################################

module "flex_mongodb" {
  source = "../.."

  project_id      = var.project_id
  name            = "example-mongodb-replica"
  mongodb_version = "7.0"
  acl             = ["10.0.0.0/8"]
  backup_schedule = "0 0 * * *"

  # Native replica set.
  replicas = 3

  flavor = {
    cpu = 2
    ram = 8
  }

  storage = {
    class = "premium-perf2-mongodb"
    size  = 20
  }

  options = {
    type                       = "Replica"
    point_in_time_window_hours = 30
    snapshot_retention_days    = 7
  }

  users = {
    app = {
      username = "app-user"
      database = "app_db"
      roles    = ["readWrite"]
    }
  }
}
