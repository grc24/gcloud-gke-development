variable "repository_name" {
  default     = "gcloud-gke-development"
  description = "Name of repository for gke"
  type        = string
}
variable "hostname" {
  type        = string
  description = "The Terraform Cloud/Enterprise hostname to connect to"
  default     = "app.terraform.io"
}

variable "oauth_name" {
  type    = string
  default = "tdd-github"
}

variable "organization" {
  type        = string
  description = "Terraform  Cloud Organization"
  default     = "aws_david_20"
}

variable "gh_pat" {
  type        = string
  description = "Github Personal Access Token"
}
variable "tfe_token" {
  type = string
  description = "Terraform Cloud Token"
}
