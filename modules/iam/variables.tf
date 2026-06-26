variable "name_prefix" {
  description = "Prefix applied to resource names"
  type        = string
}

variable "role_name" {
  description = "IAM role name for EC2"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket the EC2 instance may access"
  type        = string
}

variable "ecr_repository_arns" {
  description = "List of ECR repository ARNs the EC2 instance may access"
  type        = list(string)
  default     = []
}

variable "extra_policy_arns" {
  description = "Additional managed policy ARNs to attach to the EC2 role"
  type        = list(string)
  default     = []
}
