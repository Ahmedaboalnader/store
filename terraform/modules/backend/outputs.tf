output "backend_service_name" {
  value = google_cloud_run_v2_service.backend_service.name
}

output "backend_url" {
  description = "Public URL for the backend Cloud Run service"
  value       = try(google_cloud_run_v2_service.backend_service.uri, google_cloud_run_v2_service.backend_service.status[0].url)
}

