output "user_ids" {
  description = "Map of user key to user ID."
  value       = { for k, u in stackit_mongodbflex_user.this : k => u.user_id }
}

output "usernames" {
  description = "Map of user key to username."
  value       = { for k, u in stackit_mongodbflex_user.this : k => u.username }
}

output "hosts" {
  description = "Map of user key to host."
  value       = { for k, u in stackit_mongodbflex_user.this : k => u.host }
}

output "passwords" {
  description = "Map of user key to generated password. Sensitive."
  value       = { for k, u in stackit_mongodbflex_user.this : k => u.password }
  sensitive   = true
}

output "uris" {
  description = "Map of user key to connection URI. Sensitive."
  value       = { for k, u in stackit_mongodbflex_user.this : k => u.uri }
  sensitive   = true
}
