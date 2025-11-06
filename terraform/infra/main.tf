resource "google_service_account" "cloud_run_sa" {
  account_id   = "cloud-run-sa"
  display_name = "Cloud Run Service Account"
}

resource "google_project_iam_binding" "cloud_run_sa_sql" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  members = [
    "serviceAccount:${google_service_account.cloud_run_sa.email}"
  ]
}


resource "google_project_service" "enable_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com",
    "vpcaccess.googleapis.com",
    "run.googleapis.com"
  ])
  service = each.key
}

module "vpc" {
  source               = "../modules/vpc"
  vpc_name             = "store-vpc"
  region               = var.region
  backend_subnet_cidr  = "10.0.1.0/24"
  database_subnet_cidr = "10.0.2.0/24"
}

module "database" {
  source           = "../modules/database"
  db_instance_name = "store-sql-instance"
  region           = var.region
  project_id       = var.project_id
  db_user          = "app_user"
  db_password      = "ChangeMe123"
  db_name          = "app_db"
  vpc_self_link    = module.vpc.vpc_self_link
}

module "artifact_registry" {
  source = "../modules/artifact_registry"
  region = var.region
}

resource "google_vpc_access_connector" "cloud_run_connector" {
  name          = "cloud-run-connector"
  region        = var.region
  network       = module.vpc.vpc_self_link   
  ip_cidr_range = var.connector_ip_cidr
  min_instances = 2
  max_instances = 5

  # lifecycle {
  #   prevent_destroy = true
  #   ignore_changes  = all
  # }
}
