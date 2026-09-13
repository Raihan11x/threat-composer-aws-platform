variable "name_prefix" {
  description = "Prefix used to name load balancer resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC containing the load balancer"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs used by the load balancer"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "At least two public subnet IDs are required."
  }
}

variable "certificate_arn" {
  description = "ARN of the validated ACM certificate"
  type        = string
}

variable "app_port" {
  description = "Port exposed by the application container"
  type        = number
  default     = 8080

  validation {
    condition = (
      var.app_port >= 1 &&
      var.app_port <= 65535 &&
      floor(var.app_port) == var.app_port
    )
    error_message = "app_port must be a whole number between 1 and 65535."
  }
}

variable "health_check_path" {
  description = "HTTP path used by the target group health check"
  type        = string
  default     = "/"
}

variable "common_tags" {
  description = "Tags applied to load balancer resources"
  type        = map(string)
  default     = {}
}
