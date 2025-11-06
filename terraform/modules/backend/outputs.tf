output "backend_url" {
  description = "Public URL for the backend"
  value       = google_cloud_run_service.backend_service.status[0].url
}

output "backend_service_name" {
  value = google_cloud_run_service.backend_service.name
}

