# terraform/environments/dev/terraform.tfvars
environment = "dev"
backend_min_instances = 1
backend_max_instances = 2
db_instance_class = "db.t3.micro"
enable_nat_gateway = false

# Tags
tags = {
  Project     = "Spotify-Clone"
  ManagedBy   = "Terraform"
  Environment = "dev"
  CostCenter  = "development"
}