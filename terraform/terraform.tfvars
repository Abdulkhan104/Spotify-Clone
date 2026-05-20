# terraform/terraform.tfvars
# AWS Configuration
aws_region   = "us-east-1"
environment  = "dev"

# Database Credentials
db_username = "databse-1"
db_password = "Cloud$123"  # Change this!

# Spotify API Credentials
spotify_client_id     = "your_actual_client_id_here"
spotify_client_secret = "your_actual_client_secret_here"

# Optional: Override defaults for production
# backend_min_instances = 2
# backend_max_instances = 10
# db_instance_class = "db.t3.small"