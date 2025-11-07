output "backend_url" {
  value = google_cloud_run_v2_service.backend_service.uri
}

output "backend_service_name" {
  value = google_cloud_run_v2_service.backend_service.name
}

