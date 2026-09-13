variable "aws_region" {
  description = "AWS region used for the Terraform state resources"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name used to identify the Terraform state resources"
  type        = string
  default     = "threat-composer"
}

variable "environment" {
  description = "Environment name used to identify the Terraform state resources"
  type        = string
  default     = "prod"
}

variable "github_repository" {
  description = "GitHub repository allowed to deploy infrastructure"
  type        = string
  default     = "Raihan11x/threat-composer-aws-platform"

  validation {
    condition     = can(regex("^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$", var.github_repository))
    error_message = "GitHub repository must use the owner/repository format."
  }
}

variable "github_repository_owner_id" {
  description = "Immutable numeric GitHub repository owner ID"
  type        = string
  default     = "69002087"

  validation {
    condition     = can(regex("^[0-9]+$", var.github_repository_owner_id))
    error_message = "GitHub repository owner ID must contain only digits."
  }
}

variable "github_repository_id" {
  description = "Immutable numeric GitHub repository ID"
  type        = string
  default     = "1268246985"

  validation {
    condition     = can(regex("^[0-9]+$", var.github_repository_id))
    error_message = "GitHub repository ID must contain only digits."
  }
}
