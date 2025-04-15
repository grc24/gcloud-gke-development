##### GCP CLOUD
variable "project_id" {
  type        = string
  description = "(Required) Google cloud Project ID"
  sensitive   = true
}

variable "gcp_region" {
  type        = string
  description = "(Required) GCP Region"
  default     = "us-east1"
}

variable "subnetwork" {
  type        = string
  description = "(Required) Network to deploy"
  default     = "10.10.0.0/24"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

variable "gke_version_prefix" {
  type        = string
  description = "GKE Version"
  default     = "1.27."
}

variable "GOOGLE_CREDENTIALS" {
  description = "Google Credentials API"
}