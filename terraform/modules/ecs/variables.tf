variable "name_prefix" {
  description = "Prefix used to name ECS resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC containing the ECS service"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs used by the ECS tasks"
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnet IDs are required."
  }
}

variable "load_balancer_security_group_id" {
  description = "ID of the load balancer security group allowed to reach the tasks"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the load balancer target group"
  type        = string
}

variable "image_uri" {
  description = "Complete container image URI deployed by the ECS service"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN assumed by the application container"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the application container"
  type        = number
  default     = 8080

  validation {
    condition = (
      var.container_port >= 1 &&
      var.container_port <= 65535 &&
      floor(var.container_port) == var.container_port
    )
    error_message = "container_port must be a whole number between 1 and 65535."
  }
}

variable "desired_count" {
  description = "Number of ECS tasks maintained by the service"
  type        = number
  default     = 1

  validation {
    condition     = var.desired_count >= 1 && floor(var.desired_count) == var.desired_count
    error_message = "desired_count must be a whole number of at least 1."
  }
}

variable "task_cpu" {
  description = "CPU units allocated to each Fargate task"
  type        = number
  default     = 256

  validation {
    condition     = contains([256, 512, 1024, 2048, 4096, 8192, 16384], var.task_cpu)
    error_message = "task_cpu must be a supported Fargate CPU value."
  }
}

variable "task_memory" {
  description = "Memory in MiB allocated to each Fargate task"
  type        = number
  default     = 512

  validation {
    condition     = var.task_memory >= 512 && var.task_memory <= 122880 && floor(var.task_memory) == var.task_memory
    error_message = "task_memory must be a whole number between 512 and 122880 MiB."
  }
}

variable "log_retention_days" {
  description = "Number of days CloudWatch retains application logs"
  type        = number
  default     = 30

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365], var.log_retention_days)
    error_message = "log_retention_days must be a supported CloudWatch retention value."
  }
}

variable "assign_public_ip" {
  description = "Whether ECS tasks receive public IP addresses"
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "Tags applied to ECS resources"
  type        = map(string)
  default     = {}
}

variable "cpu_architecture" {
  description = "CPU architecture used by the Fargate task"
  type        = string
  default     = "ARM64"

  validation {
    condition     = contains(["ARM64", "X86_64"], var.cpu_architecture)
    error_message = "cpu_architecture must be ARM64 or X86_64."
  }
}
