terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      # Allow Google provider v7.x (installed via init -upgrade) while being
      # compatible with 7.x series. Adjust if you need strict pinning.
      version = ">= 7.0.0, < 8.0.0"
    }
  }
  
  # Compatible with Terraform 1.x (workflow uses 1.13.0)
  required_version = ">= 1.0.0, < 2.0.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
