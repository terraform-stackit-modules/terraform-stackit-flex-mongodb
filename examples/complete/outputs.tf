output "instance_id" {
  description = "The ID of the MongoDB Flex instance created by the example."
  value       = module.flex_mongodb.instance_id
}

output "user_ids" {
  description = "The user IDs created by the example (app + reporting)."
  value       = module.flex_mongodb.user_ids
}
