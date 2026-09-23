output "instance_id" {
  description = "The ID of the MongoDB Flex replica-set instance created by the example."
  value       = module.flex_mongodb.instance_id
}
