variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource naming (used in tags)"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable S3 versioning"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow destroying non-empty bucket"
  type        = bool
  default     = false
}
