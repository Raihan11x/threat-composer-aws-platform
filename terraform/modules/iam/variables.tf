variable "name_prefix" {
  description = "Prefix used to name IAM resources"
  type        = string
}

variable "common_tags" {
  description = "Tags applied to IAM resources"
  type        = map(string)
  default     = {}
}
