# terraform/modules/frontend/variables.tf
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "bucket_prefix" {
  description = "Prefix for S3 bucket name"
  type        = string
  default     = "spotify-clone-frontend"
}

variable "cloudfront_price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"  # USA and Europe only
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}