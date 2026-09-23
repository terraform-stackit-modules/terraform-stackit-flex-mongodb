# ─── Core ─────────────────────────────────────────────────────────────────────

variable "project_id" {
  description = "STACKIT project ID to which the MongoDB Flex instance and its users are associated."
  type        = string
}

variable "region" {
  description = "The resource region. If not defined, the provider region is used."
  type        = string
  default     = null
}

# ─── Instance ─────────────────────────────────────────────────────────────────

variable "create_instance" {
  description = "Whether to create the MongoDB Flex instance. Set to false to manage users against an existing instance provided via `instance_id`."
  type        = bool
  default     = true
}

variable "instance_id" {
  description = "ID of an existing MongoDB Flex instance. Used for users when `create_instance` is false."
  type        = string
  default     = null
}

variable "name" {
  description = "Instance name."
  type        = string
  default     = null
}

variable "mongodb_version" {
  description = "The MongoDB version, e.g. \"7.0\"."
  type        = string
  default     = null
}

variable "acl" {
  description = "The Access Control List (ACL): list of CIDRs allowed to connect to the instance."
  type        = list(string)
  default     = []
}

variable "flavor" {
  description = "Compute flavor: `{ cpu = <vCPU>, ram = <GB> }`. Required when create_instance is true."
  type = object({
    cpu = number
    ram = number
  })
  default = null
}

variable "replicas" {
  description = "Number of replicas. 1 for Single, 3 for a Replica set. Required when create_instance is true."
  type        = number
  default     = null
}

variable "storage" {
  description = "Storage configuration: `{ class = <storage class>, size = <GB> }`. Required when create_instance is true."
  type = object({
    class = string
    size  = number
  })
  default = null
}

variable "options" {
  description = <<-EOT
    Instance options (required when create_instance is true):
      - `type`                       : `Single`, `Replica`, or `Sharded`.
      - `point_in_time_window_hours` : hours of point-in-time recovery.
      - `snapshot_retention_days`, `daily_snapshot_retention_days`,
        `weekly_snapshot_retention_weeks`, `monthly_snapshot_retention_months` : optional retentions.
  EOT
  type = object({
    type                              = string
    point_in_time_window_hours        = number
    snapshot_retention_days           = optional(number)
    daily_snapshot_retention_days     = optional(number)
    weekly_snapshot_retention_weeks   = optional(number)
    monthly_snapshot_retention_months = optional(number)
  })
  default = null
}

variable "backup_schedule" {
  description = "Cron expression for the backup schedule, e.g. \"0 0 * * *\". Required when create_instance is true."
  type        = string
  default     = null
}

# ─── Users ────────────────────────────────────────────────────────────────────

variable "users" {
  description = <<-EOT
    Map of users to create, keyed by a stable identifier. Each value:
      - `username`            : the user name.
      - `database`            : the database the user is scoped to.
      - `roles`               : set of access roles (e.g. ["read"], ["readWrite"]).
      - `rotate_when_changed` : optional map whose change forces password rotation.
    Generated passwords/URIs are exposed via the `user_passwords` / `user_uris` outputs (sensitive).
  EOT
  type = map(object({
    username            = string
    database            = string
    roles               = set(string)
    rotate_when_changed = optional(map(string))
  }))
  default = {}
}
