output "security_group_id" {
  description = "ID of the load balancer security group"
  value       = aws_security_group.alb.id
}

output "target_group_arn" {
  description = "ARN of the application target group"
  value       = aws_lb_target_group.app.arn
}

output "dns_name" {
  description = "DNS name of the application load balancer"
  value       = aws_lb.application.dns_name
}

output "zone_id" {
  description = "Canonical hosted zone ID of the application load balancer"
  value       = aws_lb.application.zone_id
}
