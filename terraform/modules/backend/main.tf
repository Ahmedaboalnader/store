resource "google_cloud_run_service" "backend_service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
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
        ports {
          container_port = var.port_backend
        }
      }

      container_concurrency = 80
      service_account_name  = var.service_account_name

      vpc_access {
        connector = var.vpc_connector_id
        egress    = "ALL_TRAFFIC"
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
