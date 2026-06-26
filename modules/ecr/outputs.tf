output "repository_urls" {
  description = "Map of short name → ECR repository URL"
  value = {
    for name, repo in aws_ecr_repository.this :
    name => repo.repository_url
  }
}

output "repository_arns" {
  description = "List of ECR repository ARNs"
  value       = [for repo in aws_ecr_repository.this : repo.arn]
}

output "repository_names" {
  description = "List of full ECR repository names"
  value       = [for repo in aws_ecr_repository.this : repo.name]
}
