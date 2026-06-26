locals {
  name_prefix   = "${var.project_name}-${var.environment}"
  iam_role_name = var.iam_role_name != "" ? var.iam_role_name : "${local.name_prefix}-ec2-role"
}

# ─── Security Group ───────────────────────────────────────────────────────────
module "security_group" {
  source = "./modules/security-group"

  name_prefix       = local.name_prefix
  vpc_id            = var.vpc_id
  allowed_ssh_cidrs = var.allowed_ssh_cidrs
  allowed_app_cidrs = var.allowed_app_cidrs
  app_port          = var.app_port
}

# ─── IAM ──────────────────────────────────────────────────────────────────────
module "iam" {
  source = "./modules/iam"

  name_prefix           = local.name_prefix
  role_name             = local.iam_role_name
  s3_bucket_arn         = module.s3.bucket_arn
  ecr_repository_arns   = module.ecr.repository_arns
  extra_policy_arns     = var.extra_iam_policy_arns
}

# ─── EC2 ──────────────────────────────────────────────────────────────────────
module "ec2" {
  source = "./modules/ec2"

  name_prefix         = local.name_prefix
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  key_name            = var.key_name
  subnet_id           = var.subnet_id
  security_group_id   = module.security_group.security_group_id
  iam_instance_profile = module.iam.instance_profile_name
  associate_public_ip = var.associate_public_ip
  root_volume_size    = var.root_volume_size
}

# ─── S3 ───────────────────────────────────────────────────────────────────────
module "s3" {
  source = "./modules/s3"

  bucket_name       = var.s3_bucket_name
  versioning_enabled = var.s3_versioning_enabled
  force_destroy     = var.s3_force_destroy
  name_prefix       = local.name_prefix
}

# ─── ECR ──────────────────────────────────────────────────────────────────────
module "ecr" {
  source = "./modules/ecr"

  name_prefix              = local.name_prefix
  repositories             = var.ecr_repositories
  image_tag_mutability     = var.ecr_image_tag_mutability
  scan_on_push             = var.ecr_scan_on_push
  lifecycle_keep_count     = var.ecr_lifecycle_keep_count
}
