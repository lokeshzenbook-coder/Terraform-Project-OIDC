variable "name_prefix" {
  description = "Prefix applied to resource names"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID to attach to the instance"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name to attach to the instance"
  type        = string
}

variable "associate_public_ip" {
  description = "Associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20
}
