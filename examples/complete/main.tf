#####################################################################################
# "complete" example — self-contained, requires only `project_id`.
#
# Prod-like MongoDB Flex: restricted ACL, larger flavor/storage, a replica set for
# HA, and multiple users (app read-write + reporting read-only). Mirrors the
# "complete-*" examples of terraform-aws-modules/terraform-aws-rds.
#
# NOTE: the larger flavor (2.8) does not support the "Single" topology — STACKIT
# reserves it for Replica/Sharded ("Type Single not available for Flavor 2.8"). A
# prod-like instance is a replica set anyway.
#####################################################################################

module "flex_mongodb" {
  source = "../.."

  project_id      = var.project_id
  name            = "example-mongodb-complete"
  mongodb_version = "7.0"
  acl             = ["10.0.0.0/8"]
  replicas        = 3
  backup_schedule = "0 2 * * *"

  flavor = {
    cpu = 2
    ram = 8
  }

  storage = {
    class = "premium-perf2-mongodb"
    size  = 20
  }

  options = {
    type                            = "Replica"
    point_in_time_window_hours      = 30
    snapshot_retention_days         = 7
    weekly_snapshot_retention_weeks = 4
  }

  users = {
    app = {
      username = "app-user"
      database = "app_db"
      roles    = ["readWrite"]
    }
    reporting = {
      username = "reporting-user"
      database = "app_db"
      roles    = ["read"]
    }
  }
}
