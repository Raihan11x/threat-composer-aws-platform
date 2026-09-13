locals {
  name_prefix  = "${var.project_name}-${var.environment}"
  app_hostname = "${var.app_subdomain}.${var.domain_name}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
