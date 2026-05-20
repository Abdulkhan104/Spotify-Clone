# terraform/outputs.tf
output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "backend_url" {
  description = "Backend Elastic Beanstalk URL"
  value       = module.backend.backend_url
}

output "frontend_url" {
  description = "Frontend CloudFront URL"
  value       = module.frontend.cloudfront_url
}

output "database_endpoint" {
  description = "Database endpoint"
  value       = module.database.database_endpoint
  sensitive   = true
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.frontend.cloudfront_distribution_id
}

output "s3_bucket_name" {
  description = "Frontend S3 bucket name"
  value       = module.frontend.bucket_name
}