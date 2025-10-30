resource "google_compute_network" "main_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "subnet_backend" {
  name          = "${var.vpc_name}-subnet-backend"
  ip_cidr_range = var.backend_subnet_cidr
  region        = var.region
  network       = google_compute_network.main_vpc.id
}

resource "google_compute_subnetwork" "subnet_database" {
  name          = "${var.vpc_name}-subnet-database"
  ip_cidr_range = var.database_subnet_cidr
  region        = var.region
  network       = google_compute_network.main_vpc.id
}

# Firewall rule: allow internal communication
resource "google_compute_firewall" "allow_internal" {
  name    = "${var.vpc_name}-allow-internal"
  network = google_compute_network.main_vpc.name

  allow {
    protocol = "all"
  }

  source_ranges = [var.backend_subnet_cidr, var.database_subnet_cidr]
}

# Firewall rule: allow HTTP (for backend/frontend)
resource "google_compute_firewall" "allow_http" {
  name    = "${var.vpc_name}-allow-http"
  network = google_compute_network.main_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_vpc_access_connector" "cloud_run_connector" {
  name          = "cloud-run-redis-connector"
  region        = var.region
  network       = google_compute_network.main_vpc.name
  ip_cidr_range = var.connector_ip_cidr
  min_instances = 2
  max_instances = 5
}
