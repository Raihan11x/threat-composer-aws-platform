output "route53_name_servers" {
  description = "Route 53 name servers to configure at the domain registrar"
  value       = module.route53_zone.name_servers
}
