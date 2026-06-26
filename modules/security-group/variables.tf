variable "name_prefix" {
  description = "Prefix applied to resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed SSH access (port 22)"
  type        = list(string)
  default     = []
}

variable "allowed_app_cidrs" {
  description = "CIDR blocks allowed access on app_port"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_port" {
  description = "Application port to open inbound"
  type        = number
  default     = 8080
}
