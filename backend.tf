terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"   # replace with your S3 bucket name
    key            = "terraform/state/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"        # replace with your DynamoDB table name
    encrypt        = true
  }
}
