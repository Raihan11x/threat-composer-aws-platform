variable "domain_name" {
  description = "Fully qualified domain name secured by the certificate"
  type        = string

  validation {
    condition     = length(trimspace(var.domain_name)) > 0
    error_message = "domain_name must not be empty."
  }
}

variable "hosted_zone_id" {
  description = "Route 53 hosted zone ID used for certificate validation"
  type        = string
}

variable "common_tags" {
  description = "Tags applied to ACM resources"
  type        = map(string)
  default     = {}
}
