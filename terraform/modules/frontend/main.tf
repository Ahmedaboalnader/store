# Artifact Registry (لصور الفرونت)
resource "google_artifact_registry_repository" "frontend_repo" {
  provider     = google
  location     = var.region
  repository_id = "frontend-repo"
  format       = "DOCKER"
}

# Cloud Run Service (Frontend)
resource "google_cloud_run_service" "frontend_service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      timeout_seconds = 500
      containers {
        image = var.image
        ports {
          container_port = var.port-frontend
        }
        env {
          name  = "REACT_APP_API_URL"
          value = var.backend_url
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Allow Public Access (لأي زائر)
resource "google_cloud_run_service_iam_member" "frontend_public_access" {
  location = var.region
  service  = google_cloud_run_service.frontend_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Load Balancer (اختياري لتثبيت الـ DNS)
resource "google_compute_region_network_endpoint_group" "frontend_neg" {
  name                  = "${var.service_name}-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = google_cloud_run_service.frontend_service.name
  }
}

# Backend Service for Load Balancer
# resource "google_compute_region_backend_service" "frontend_backend_lb" {
  # name                  = "${var.service_name}-lb"
  # region                = var.region
  # load_balancing_scheme = "EXTERNAL_MANAGED"
  # protocol              = "HTTP"

  # backend {
  #   group           = google_compute_region_network_endpoint_group.frontend_neg.id
    # capacity_scaler = 1.0
  # }
# # }

