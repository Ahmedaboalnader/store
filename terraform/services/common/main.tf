resource "google_service_account" "cloud_run_sa" {
  account_id   = "cloud-run-service-account"
  display_name = "Cloud Run Service Account"
}

resource "google_project_iam_binding" "cloudsql_access" {
  project = var.project_id
  role    = "roles/cloudsql.client"

  members = [
    "serviceAccount:${google_service_account.cloud_run_sa.email}"
  ]
}

output "service_account_email" {
  value = google_service_account.cloud_run_sa.email
}
