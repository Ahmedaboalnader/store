output "backend_repo" {
  value = google_artifact_registry_repository.backend_repo.repository_id
}

output "frontend_repo" {
  value = google_artifact_registry_repository.frontend_repo.repository_id
}