output "route53_name_servers" {
  description = "Route 53 name servers to configure at the domain registrar"
  value       = module.route53_zone.name_servers
}

output "application_url" {
  description = "HTTPS URL of the deployed application"
  value       = "https://${module.dns_alias.fqdn}"
}
