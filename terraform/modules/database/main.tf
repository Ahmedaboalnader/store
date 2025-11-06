resource "google_compute_global_address" "private_ip_range" {
  name          = "private-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "projects/${var.project_id}/global/networks/${var.vpc_name}"
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = "projects/${var.project_id}/global/networks/${var.vpc_name}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]

  depends_on = [google_compute_global_address.private_ip_range]
}

resource "google_sql_database_instance" "db_instance" {
  name             = var.db_instance_name
  region           = var.region
  deletion_protection = false
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
  ipv4_enabled    = false
  private_network = var.vpc_self_link
     }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_database" "app_database" {
  name     = var.db_name
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_user" "app_user" {
  name     = var.db_user
  instance = google_sql_database_instance.db_instance.name
  password = var.db_password
}

