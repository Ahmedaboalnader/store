terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      # Keep provider constraint aligned with infra; permit 7.x
      version = "7.10.0"
    }
  }
  # Require Terraform 1.x (workflow uses 1.13.0)
  required_version = ">= 1.0.0, < 2.0.0"

  backend "remote" {
    hostname = "app.terraform.io"
    organization = "ahmedaboalnder"
    workspaces {
      name = "my-services"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  # zone    = var.zone
}
