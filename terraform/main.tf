# terraform/main.tf
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Data source for availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Module: Networking
module "networking" {
  source = "./modules/networking"

  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = data.aws_availability_zones.available.names[0:2]
  
  enable_nat_gateway = var.enable_nat_gateway
  
  tags = var.tags
}

# Module: Security (Secrets & IAM)
module "security" {
  source = "./modules/security"

  environment = var.environment
  
  spotify_client_id     = var.spotify_client_id
  spotify_client_secret = var.spotify_client_secret
  
  tags = var.tags
}

# Module: Database
module "database" {
  source = "./modules/database"

  environment = var.environment
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  
  instance_class = var.db_instance_class
  
  subnet_ids         = module.networking.private_subnet_ids
  security_group_id  = module.networking.rds_security_group_id
  
  tags = var.tags
}

# Module: Backend
module "backend" {
  source = "./modules/backend"

  environment = var.environment
  aws_region  = var.aws_region
  
  vpc_id                 = module.networking.vpc_id
  public_subnet_ids      = module.networking.public_subnet_ids
  backend_security_group_id = module.networking.backend_security_group_id
  
  database_connection_string = module.database.database_connection_string
  
  ec2_instance_profile_name = module.security.eb_ec2_instance_profile_name
  secrets_manager_name      = module.security.secrets_manager_arn
  
  min_instances = var.backend_min_instances
  max_instances = var.backend_max_instances
  instance_type = var.backend_instance_type
  
  tags = var.tags
}

# Module: Frontend
module "frontend" {
  source = "./modules/frontend"

  environment    = var.environment
  bucket_prefix  = var.frontend_bucket_prefix
  
  tags = var.tags
}