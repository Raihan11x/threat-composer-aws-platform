output "zone_id" {
  description = "ID of the public Route 53 hosted zone"
  value       = aws_route53_zone.this.zone_id
}

output "name_servers" {
  description = "Name servers used to delegate the registered domain"
  value       = aws_route53_zone.this.name_servers
}
