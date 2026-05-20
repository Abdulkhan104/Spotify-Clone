# terraform/environments/prod/terraform.tfvars
environment = "prod"
backend_min_instances = 2
backend_max_instances = 10
db_instance_class = "db.t3.small"
enable_nat_gateway = true

# Tags
tags = {
  Project     = "Spotify-Clone"
  ManagedBy   = "Terraform"
  Environment = "production"
  CostCenter  = "production"
}