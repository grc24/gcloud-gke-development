terraform {
  required_providers {
    github = {
        source = "integrations/github"
        version = "~> 5.0"
    }

    tfe     = {
        source  = "hashicorp/tfe"
        version = ">=0.45.0"
    }
  }
}