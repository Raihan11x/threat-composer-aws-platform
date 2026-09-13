output "fqdn" {
  description = "Fully qualified domain name of the application"
  value       = aws_route53_record.application.fqdn
}
