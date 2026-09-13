output "state_bucket_name" {
  description = "Name of the S3 bucket storing Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "github_actions_terraform_role_arn" {
  description = "ARN of the IAM role used by the Terraform GitHub Actions workflow"
  value       = aws_iam_role.github_actions_terraform.arn
}
