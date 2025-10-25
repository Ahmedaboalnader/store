output "frontend_url" {
  description = "Public URL of the frontend service"
  value       = google_cloud_run_service.frontend_service.status[0].url
}
