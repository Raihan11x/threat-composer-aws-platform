variable "domain_name" {
  description = "Registered domain used for the public hosted zone"
  type        = string

  validation {
    condition     = length(trimspace(var.domain_name)) > 0
    error_message = "domain_name must not be empty."
  }
}

variable "common_tags" {
  description = "Tags applied to Route 53 resources"
  type        = map(string)
  default     = {}
}
