# ─── Global ───────────────────────────────────────────────────────────────────
aws_region   = "us-east-1"
project_name = "myapp"
environment  = "dev"
owner        = "lokesh"

# ─── EC2 ──────────────────────────────────────────────────────────────────────
ami_id              = "ami-0f58b397bc5c1f2e8"   # Amazon Linux 2023, ap-south-1
instance_type       = "t3.micro"
key_name            = "my-keypair"
subnet_id           = "subnet-0f5cee9681c2736b1"
vpc_id              = "vpc-0188491b1a7750192"
associate_public_ip = false
root_volume_size    = 20

# Allow SSH only from a bastion / your IP
allowed_ssh_cidrs = ["10.0.0.0/8"]
allowed_app_cidrs = ["0.0.0.0/0"]
app_port          = 8080

# ─── S3 ───────────────────────────────────────────────────────────────────────
s3_bucket_name        = "myapp-dev-artifacts-2024"
s3_versioning_enabled = true
s3_force_destroy      = false

# ─── IAM ──────────────────────────────────────────────────────────────────────
iam_role_name         = ""    # leave blank → auto-generated from project/env
extra_iam_policy_arns = []

# ─── ECR ──────────────────────────────────────────────────────────────────────
ecr_repositories         = ["frontend", "backend", "worker"]
ecr_image_tag_mutability = "IMMUTABLE"
ecr_scan_on_push         = true
ecr_lifecycle_keep_count = 10
