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
