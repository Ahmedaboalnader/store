resource "google_cloud_run_v2_service" "backend_service" {
  name   = var.service_name
  location = var.region
  deletion_protection = false

  template {
    containers {
      image = var.image
      ports {
        container_port = var.port_backend
      }
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

    service_account = var.service_account_name

    vpc_access {
      connector = var.vpc_connector_id
      egress    = "ALL_TRAFFIC"
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 3
    }
  }

  ingress = "INGRESS_TRAFFIC_ALL"

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

resource "google_cloud_run_v2_service_iam_member" "public_access" {
  name = "projects/${var.project_id}/locations/${var.region}/services/${google_cloud_run_v2_service.backend_service.name}/iamMember/allUsers"
  # service  = google_cloud_run_v2_service.backend_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                  = "${var.service_name}-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"

  cloud_run {
    service = google_cloud_run_v2_service.backend_service.name
  }
}
