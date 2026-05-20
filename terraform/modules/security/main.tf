# terraform/modules/security/main.tf
# IAM Role for Elastic Beanstalk Service
resource "aws_iam_role" "eb_service_role" {
  name = "${var.environment}-spotify-eb-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "eb_service_policy" {
  role       = aws_iam_role.eb_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

# IAM Role for EC2 instances
resource "aws_iam_role" "eb_ec2_role" {
  name = "${var.environment}-spotify-eb-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "eb_ec2_policy" {
  role       = aws_iam_role.eb_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

# Custom policy for Secrets Manager access
resource "aws_iam_policy" "secrets_access" {
  name        = "${var.environment}-spotify-secrets-access"
  description = "Allow access to Spotify API secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = aws_secretsmanager_secret.spotify_api_keys.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eb_secrets_attachment" {
  role       = aws_iam_role.eb_ec2_role.name
  policy_arn = aws_iam_policy.secrets_access.arn
}

# Secrets Manager for Spotify API Keys
resource "aws_secretsmanager_secret" "spotify_api_keys" {
  name        = "${var.environment}-spotify-api-keys"
  description = "Spotify API credentials for the application"

  rotation_rules {
    automatically_after_days = var.secret_rotation_days
  }

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "spotify_creds" {
  secret_id = aws_secretsmanager_secret.spotify_api_keys.id
  secret_string = jsonencode({
    SPOTIFY_CLIENT_ID     = var.spotify_client_id
    SPOTIFY_CLIENT_SECRET = var.spotify_client_secret
  })
}

# Output IAM role names for other modules
resource "aws_iam_instance_profile" "eb_ec2_profile" {
  name = "${var.environment}-spotify-eb-ec2-profile"
  role = aws_iam_role.eb_ec2_role.name
}