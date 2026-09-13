variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Name used to prefix AWS resources"
  type        = string
  default     = "threat-composer"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "prod"
}

variable "domain_name" {
  description = "Registered .co.uk domain used for the application"
  type        = string

  validation {
    condition     = endswith(lower(var.domain_name), ".co.uk")
    error_message = "domain_name must end with .co.uk."
  }
}

variable "app_subdomain" {
  description = "Subdomain used for the application"
  type        = string
  default     = "app"
}

variable "image_tag" {
  description = "Immutable Git commit tag of the ECR image to deploy"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-f]{7,40}$", var.image_tag))
    error_message = "image_tag must be a 7 to 40 character lowercase Git commit SHA."
  }
}

variable "desired_count" {
  description = "Number of Fargate tasks to run"
  type        = number
  default     = 1

  validation {
    condition = (
      var.desired_count >= 1 &&
      floor(var.desired_count) == var.desired_count
    )
    error_message = "desired_count must be a whole number of at least 1."
  }
}
