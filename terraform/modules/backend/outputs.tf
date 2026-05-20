# terraform/modules/backend/outputs.tf
output "backend_url" {
  value = "http://${aws_elastic_beanstalk_environment.this.cname}.elasticbeanstalk.com"
}

output "application_name" {
  value = aws_elastic_beanstalk_application.this.name
}

output "environment_name" {
  value = aws_elastic_beanstalk_environment.this.name
}