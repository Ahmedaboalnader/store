output "vpc_name" {
  description = "VPC network name"
  value       = google_compute_network.main_vpc.name
}

output "backend_subnet" {
  description = "Backend subnet self link"
  value       = google_compute_subnetwork.subnet_backend.self_link
}

output "database_subnet" {
  description = "Database subnet self link"
  value       = google_compute_subnetwork.subnet_database.self_link
}


