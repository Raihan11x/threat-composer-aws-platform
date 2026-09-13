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
  default     = "Raihan11x/Rai-ECS-CoderCo"

  validation {
    condition     = can(regex("^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$", var.github_repository))
    error_message = "GitHub repository must use the owner/repository format."
  }
}
