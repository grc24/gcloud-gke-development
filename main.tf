resource "github_repository" "main" {
  name               = var.repository_name
  description        = "Terraform create repository for Google GKE"
  visibility         = "public"
  auto_init          = true
  gitignore_template = "Terraform"
}

resource "github_branch" "main" {
  repository = github_repository.main.name
  branch     = "main"
}

resource "github_branch_default" "main" {
  repository = github_repository.main.name
  branch     = github_branch.main.branch
}

### Terraform Cloud configuration
provider "tfe" {
  hostname = var.hostname
}

resource "tfe_oauth_client" "github" {
  name             = var.oauth_name
  organization     = var.organization
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.gh_pat
  service_provider = "github"
}

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

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.primary.name
  location = var.gcp_region
  cluster  = google_container_cluster.primary.name

  version    = data.google_container_engine_versions.gke_version.release_channel_default_version["STABLE"]
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }
    machine_type = "e2-medium"

    disk_type    = "pd-ssd"
    disk_size_gb = 50

    # preemptible  = true
    #machine_type = "n1-standard-1"
    tags = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}