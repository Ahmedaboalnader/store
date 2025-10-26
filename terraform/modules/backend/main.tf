# resource "google_artifact_registry_repository" "backend_repo" {
#   provider      = google
#   location      = var.region
#   repository_id = "backend-repo"
#   format        = "DOCKER"
# }

# Cloud Run Service (Backend)
resource "google_cloud_run_service" "backend_service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      timeout_seconds = 500
      containers {
        ports {
          container_port = var.port-backend
        }
        image = var.image

        env {
          name  = "DB_HOST"
          value = var.db_private_ip
        }
        env {
          name  = "DB_USER"
          value = var.db_user
        }
        env {
          name  = "DB_PASS"
          value = var.db_password
        }
        env {
          name  = "DB_NAME"
          value = var.db_name
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  location = var.region
  service  = google_cloud_run_service.backend_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                  = "${var.service_name}-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"

  cloud_run {
    service = google_cloud_run_service.backend_service.name
  }
}

# resource "google_compute_region_backend_service" "backend_service_lb" {
#   name                  = "${var.service_name}-lb"
#   region                = var.region
#   load_balancing_scheme = "EXTERNAL_MANAGED"
#   protocol              = "HTTP"

#   backend {
#     group           = google_compute_region_network_endpoint_group.cloudrun_neg.id
#     capacity_scaler = 1.0
#   }
# }



