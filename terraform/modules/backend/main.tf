# Cloud Run Service (Backend)
resource "google_cloud_run_service" "backend_service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      
      containers {
        ports {
          container_port = var.port_backend
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
    # Use annotations for autoscaling and VPC connector on Cloud Run (managed).
    # The provider's `google_cloud_run_service` resource expects these as
    # annotations rather than nested `scaling`/`vpc_access` blocks.
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = tostring(var.min_instances)
        "autoscaling.knative.dev/maxScale" = tostring(var.max_instances)
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector
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
