output "backend_service_name" {
  value = google_cloud_run_v2_service.backend_service.name
}

output "backend_url" {
  description = "Public URL for the backend Cloud Run service"
  # Use the Cloud Run v2 service 'uri' attribute which is provided by the
  # provider. Avoid referencing 'status' which may not be available for the
  # provider version in use.
  value = google_cloud_run_v2_service.backend_service.uri
}

