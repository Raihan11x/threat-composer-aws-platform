output "cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.application.arn
}

output "cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.application.name
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.application.name
}

output "task_definition_arn" {
  description = "ARN of the active ECS task definition"
  value       = aws_ecs_task_definition.application.arn
}

output "task_security_group_id" {
  description = "ID of the ECS task security group"
  value       = aws_security_group.tasks.id
}
