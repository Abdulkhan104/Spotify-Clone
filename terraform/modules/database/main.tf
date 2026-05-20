# terraform/modules/database/main.tf
resource "aws_db_subnet_group" "this" {
  name        = "${var.environment}-db-subnet-group"
  subnet_ids  = var.subnet_ids
  description = "Subnet group for RDS database"

  tags = merge(var.tags, {
    Name = "${var.environment}-db-subnet-group"
  })
}

resource "aws_db_instance" "this" {
  identifier     = "${var.environment}-spotify-db"
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class
  storage_type   = var.storage_type
  allocated_storage = var.allocated_storage

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.this.name

  backup_retention_period = var.backup_retention_days
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window

  skip_final_snapshot = var.skip_final_snapshot
  publicly_accessible = false
  deletion_protection = var.deletion_protection

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = merge(var.tags, {
    Name = "${var.environment}-postgres-db"
  })
}

# Database Parameter Group
resource "aws_db_parameter_group" "this" {
  family = "postgres15"
  name   = "${var.environment}-postgres-params"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  parameter {
    name  = "log_duration"
    value = "1"
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-db-params"
  })
}