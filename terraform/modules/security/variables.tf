# terraform/modules/security/variables.tf
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "spotify_client_id" {
  description = "Spotify API Client ID"
  type        = string
  sensitive   = true
}

variable "spotify_client_secret" {
  description = "Spotify API Client Secret"
  type        = string
  sensitive   = true
}

variable "secret_rotation_days" {
  description = "Days between automatic secret rotation"
  type        = number
  default     = 90
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}