### Gcloud 
provider "google" {
  project     = var.project_id
  region      = var.gcp_region
  credentials = var.GOOGLE_CREDENTIALS
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.gcp_region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.subnetwork
}

# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location       = var.gcp_region
  version_prefix = var.gke_version_prefix
}


resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  location = var.gcp_region

  initial_node_count = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  lifecycle {
    prevent_destroy = true
  }

  node_config {
    machine_type = "e2-standard-2"
    disk_size_gb = 50
    disk_type    = "pd-ssd"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

}


