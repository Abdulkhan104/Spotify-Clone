# terraform/modules/frontend/outputs.tf
output "bucket_name" {
  value = aws_s3_bucket.this.id
}

output "bucket_website_url" {
  value = aws_s3_bucket_website_configuration.this.website_endpoint
}

output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.this.domain_name}"
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.this.id
}