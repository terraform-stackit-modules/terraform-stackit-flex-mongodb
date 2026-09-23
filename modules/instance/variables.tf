variable "project_id" {
  description = "STACKIT project ID to which the instance is associated."
  type        = string
}

variable "create_instance" {
  description = "Whether to create the MongoDB Flex instance."
  type        = bool
  default     = true
}

variable "name" {
  description = "Instance name."
  type        = string
}

variable "mongodb_version" {
  description = "The MongoDB version, e.g. \"7.0\"."
  type        = string
}

variable "region" {
  description = "The resource region. If not defined, the provider region is used."
  type        = string
  default     = null
}

variable "acl" {
  description = "The Access Control List (ACL) for the instance: list of CIDRs allowed to connect."
  type        = list(string)
  default     = []
}

variable "flavor" {
  description = "Compute flavor for the instance: `{ cpu = <vCPU>, ram = <GB> }`."
  type = object({
    cpu = number
    ram = number
  })
}

variable "replicas" {
  description = "Number of replicas. Use 1 for Single, 3 for a Replica set."
  type        = number
}

variable "storage" {
  description = "Storage configuration: `{ class = <storage class>, size = <GB> }`."
  type = object({
    class = string
    size  = number
  })
}

variable "options" {
  description = <<-EOT
    Instance options:
      - `type`                       (required) : `Single`, `Replica`, or `Sharded`.
      - `point_in_time_window_hours` (required) : hours of point-in-time recovery.
      - `snapshot_retention_days`               : retention of continuous backups.
      - `daily_snapshot_retention_days`         : retention of daily backups.
      - `weekly_snapshot_retention_weeks`       : retention of weekly backups.
      - `monthly_snapshot_retention_months`     : retention of monthly backups.
  EOT
  type = object({
    type                              = string
    point_in_time_window_hours        = number
    snapshot_retention_days           = optional(number)
    daily_snapshot_retention_days     = optional(number)
    weekly_snapshot_retention_weeks   = optional(number)
    monthly_snapshot_retention_months = optional(number)
  })

  validation {
    condition     = contains(["Single", "Replica", "Sharded"], var.options.type)
    error_message = "options.type must be one of: Single, Replica, Sharded."
  }
}

variable "backup_schedule" {
  description = "Cron expression for the backup schedule, e.g. \"0 0 * * *\"."
  type        = string
}
