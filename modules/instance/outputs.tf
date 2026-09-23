output "instance_id" {
  description = "The ID of the MongoDB Flex instance (null when create_instance is false)."
  value       = var.create_instance ? stackit_mongodbflex_instance.this[0].instance_id : null
}
