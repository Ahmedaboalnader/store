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

# data "terraform_remote_state" "infra" {
#   backend = "remote"
#   config = {
#     organization = "ahmedaboalnder"
#     workspaces {
#       name = "my-infra"
#     }
#   }
# }

# module "backend" {
#   source                = "../modules/backend"
#   region                = var.region
#   project_id            = var.project_id
#   service_name          = "store-backend"
#   image                 = "us-central1-docker.pkg.dev/konecta-task-467513/backend-repo:latest"
#   port_backend          = 5000
#   db_private_ip         = data.terraform_remote_state.infra.outputs.db_private_ip
#   db_name               = data.terraform_remote_state.infra.outputs.db_name
#   db_user               = data.terraform_remote_state.infra.outputs.db_user
#   db_password           = data.terraform_remote_state.infra.outputs.db_password
#   vpc_connector_id      = data.terraform_remote_state.infra.outputs.vpc_connector_id
#   service_account_name  = google_service_account.cloud_run_sa.email
# }
module "backend" {
  source                = "../modules/backend"
  region                = var.region
  project_id            = var.project_id
  service_name          = "store-backend"
  image                 = var.backend_image
  port_backend          = 5000
  db_private_ip         = var.db_private_ip
  db_name               = var.db_name
  db_user               = var.db_user
  db_password           = var.db_password
  vpc_connector_id      = var.vpc_connector_id
  service_account_name  = google_service_account.cloud_run_sa.email
}

module "frontend" {
  source       = "../modules/frontend"
  service_name = "frontend-service"
  region       = var.region
  image        = var.frontend_image
  port_frontend = 80

 backend_url = module.backend.backend_url  
depends_on  = [module.backend] 
}

