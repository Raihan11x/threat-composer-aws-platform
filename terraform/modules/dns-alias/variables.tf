variable "zone_id" {
  description = "ID of the Route 53 hosted zone"
  type        = string
}

variable "hostname" {
  description = "Fully qualified hostname for the application"
  type        = string
}

variable "load_balancer_dns_name" {
  description = "DNS name of the application load balancer"
  type        = string
}

variable "load_balancer_zone_id" {
  description = "Canonical hosted zone ID of the application load balancer"
  type        = string
}
