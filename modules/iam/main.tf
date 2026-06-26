data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    sid     = "EC2AssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Name = var.role_name
  }
}

# ─── Inline Policy: S3 + ECR Access ──────────────────────────────────────────
data "aws_iam_policy_document" "ec2_permissions" {
  # S3 read/write on the project bucket
  statement {
    sid    = "S3Access"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]
    resources = [
      var.s3_bucket_arn,
      "${var.s3_bucket_arn}/*",
    ]
  }

  # ECR auth token (account-level)
  statement {
    sid       = "ECRAuth"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  # ECR image pull/push on project repositories
  statement {
    sid    = "ECRAccess"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
    ]
    resources = var.ecr_repository_arns
  }

  # CloudWatch Logs
  statement {
    sid    = "CloudWatchLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }

  # SSM Parameter Store (read-only for secrets)
  statement {
    sid    = "SSMReadOnly"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]
    resources = ["arn:aws:ssm:*:*:parameter/${var.name_prefix}/*"]
  }
}

resource "aws_iam_policy" "ec2_permissions" {
  name   = "${var.role_name}-policy"
  policy = data.aws_iam_policy_document.ec2_permissions.json

  tags = {
    Name = "${var.role_name}-policy"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_permissions" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.ec2_permissions.arn
}

# ─── SSM Core (for Session Manager access) ───────────────────────────────────
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# ─── Extra managed policies (caller-supplied) ─────────────────────────────────
resource "aws_iam_role_policy_attachment" "extra" {
  for_each = toset(var.extra_policy_arns)

  role       = aws_iam_role.ec2.name
  policy_arn = each.value
}

# ─── Instance Profile ─────────────────────────────────────────────────────────
resource "aws_iam_instance_profile" "ec2" {
  name = "${var.role_name}-profile"
  role = aws_iam_role.ec2.name
}
