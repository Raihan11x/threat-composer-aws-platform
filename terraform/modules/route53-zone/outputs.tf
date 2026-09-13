output "zone_id" {
  description = "ID of the public Route 53 hosted zone"
  value       = aws_route53_zone.primary.zone_id
}

output "name_servers" {
  description = "Name servers used to delegate the registered domain"
  value       = aws_route53_zone.primary.name_servers
}
