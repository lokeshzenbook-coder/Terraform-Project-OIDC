variable "name_prefix" {
  description = "Prefix prepended to each ECR repository name"
  type        = string
}

variable "repositories" {
  description = "List of repository short names to create (prefix is added automatically)"
  type        = list(string)
  default     = []
}

variable "image_tag_mutability" {
  description = "Tag mutability setting (MUTABLE | IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Enable image vulnerability scanning on push"
  type        = bool
  default     = true
}

variable "lifecycle_keep_count" {
  description = "Number of tagged images to retain per repository"
  type        = number
  default     = 10
}
