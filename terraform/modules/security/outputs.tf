# terraform/modules/security/outputs.tf
output "eb_service_role_arn" {
  value = aws_iam_role.eb_service_role.arn
}

output "eb_ec2_role_name" {
  value = aws_iam_role.eb_ec2_role.name
}

output "eb_ec2_instance_profile_name" {
  value = aws_iam_instance_profile.eb_ec2_profile.name
}

output "secrets_manager_arn" {
  value = aws_secretsmanager_secret.spotify_api_keys.arn
}