# ─── Global ───────────────────────────────────────────────────────────────────

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name of the project (used as resource prefix)"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev / staging / prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "owner" {
  description = "Owner tag value for all resources"
  type        = string
  default     = "devops-team"
}

# ─── EC2 ──────────────────────────────────────────────────────────────────────

variable "ami_id" {
  description = "AMI ID for the EC2 instance (Amazon Linux 2023 recommended)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the existing EC2 Key Pair for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for Security Group association"
  type        = string
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP with the EC2 instance"
  type        = bool
  default     = false
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20
}

variable "allowed_ssh_cidrs" {
  description = "List of CIDR blocks allowed SSH (port 22) access"
  type        = list(string)
  default     = []
}

variable "allowed_app_cidrs" {
  description = "List of CIDR blocks allowed application port access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_port" {
  description = "Application port to open in the security group"
  type        = number
  default     = 8080
}

# ─── S3 ───────────────────────────────────────────────────────────────────────

variable "s3_bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "s3_versioning_enabled" {
  description = "Enable versioning on the S3 bucket"
  type        = bool
  default     = true
}

variable "s3_force_destroy" {
  description = "Allow Terraform to destroy non-empty bucket"
  type        = bool
  default     = false
}

# ─── IAM ──────────────────────────────────────────────────────────────────────

variable "iam_role_name" {
  description = "Name for the IAM role attached to EC2"
  type        = string
  default     = ""
}

variable "extra_iam_policy_arns" {
  description = "Additional IAM managed policy ARNs to attach to the EC2 role"
  type        = list(string)
  default     = []
}

# ─── ECR ──────────────────────────────────────────────────────────────────────

variable "ecr_repositories" {
  description = "List of ECR repository names to create"
  type        = list(string)
  default     = []
}

variable "ecr_image_tag_mutability" {
  description = "Image tag mutability for ECR repositories (MUTABLE | IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"
}

variable "ecr_scan_on_push" {
  description = "Enable image scanning on push for ECR repositories"
  type        = bool
  default     = true
}

variable "ecr_lifecycle_keep_count" {
  description = "Number of tagged images to keep per ECR repository"
  type        = number
  default     = 10
}
