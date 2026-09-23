variable "project_id" {
  description = "STACKIT project ID to which the instance is associated."
  type        = string
}

variable "instance_id" {
  description = "ID of the MongoDB Flex instance the users belong to."
  type        = string
}

variable "region" {
  description = "The resource region. If not defined, the provider region is used."
  type        = string
  default     = null
}

variable "users" {
  description = <<-EOT
    Map of users to create, keyed by a stable identifier. Each value:
      - `username`            : the user name.
      - `database`            : the database the user is scoped to.
      - `roles`               : set of access roles, e.g. ["read"], ["readWrite"].
      - `rotate_when_changed` : optional map whose change forces password rotation.
    The generated password is exposed via the `passwords` output, marked sensitive.
  EOT
  type = map(object({
    username            = string
    database            = string
    roles               = set(string)
    rotate_when_changed = optional(map(string))
  }))
  default = {}
}
