resource "google_artifact_registry_repository" "backend_repo" {
  provider      = google
  location      = var.region
  repository_id = "backend-repo"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository" "frontend_repo" {
  provider      = google
  location      = var.region
  repository_id = "frontend-repo"
  format        = "DOCKER"
}


