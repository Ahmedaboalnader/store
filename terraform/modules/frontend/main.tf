# Cloud Run Service (Frontend)
resource "google_cloud_run_service" "frontend_service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      timeout_seconds = 10
      containers {
        image = var.image

        ports {
          container_port = var.port_frontend
        }

        env {
          name  = "REACT_APP_API_URL"
          value = var.backend_url  # backend URL جاي من output الانفرا أو من main.tf
        }
      }
    }

    metadata {
      annotations = {
        "run.googleapis.com/client-name" = "terraform"
        "autoscaling.knative.dev/minScale" = "1"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

# Allow public access
resource "google_cloud_run_service_iam_member" "frontend_public_access" {
  location = var.region
  service  = google_cloud_run_service.frontend_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# NEG (for optional load balancer)
resource "google_compute_region_network_endpoint_group" "frontend_neg" {
  name                  = "${var.service_name}-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = google_cloud_run_service.frontend_service.name
  }
}
