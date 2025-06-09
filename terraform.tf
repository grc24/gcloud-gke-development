terraform {
  /* cloud {
    # Organization ID
    organization = "aws_david_20"
    # Workspace ID
    workspaces {
      name = "gcloud-gke-development"
    }
  } */
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = ">=0.45.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "4.74.0"
    }
  }
}