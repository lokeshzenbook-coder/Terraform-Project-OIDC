# ─── EC2 ──────────────────────────────────────────────────────────────────────
output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}

output "ec2_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.ec2.private_ip
}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance (if assigned)"
  value       = module.ec2.public_ip
}

# ─── Security Group ───────────────────────────────────────────────────────────
output "security_group_id" {
  description = "Security group ID attached to the EC2 instance"
  value       = module.security_group.security_group_id
}

# ─── IAM ──────────────────────────────────────────────────────────────────────
output "iam_role_arn" {
  description = "ARN of the IAM role attached to EC2"
  value       = module.iam.role_arn
}

output "iam_instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = module.iam.instance_profile_name
}

# ─── S3 ───────────────────────────────────────────────────────────────────────
output "s3_bucket_id" {
  description = "S3 bucket name"
  value       = module.s3.bucket_id
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.s3.bucket_arn
}

# ─── ECR ──────────────────────────────────────────────────────────────────────
output "ecr_repository_urls" {
  description = "Map of ECR repository name → URL"
  value       = module.ecr.repository_urls
}

output "ecr_repository_arns" {
  description = "List of ECR repository ARNs"
  value       = module.ecr.repository_arns
}
