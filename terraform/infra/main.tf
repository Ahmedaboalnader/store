
resource "google_project_service" "enable_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com", 
  ])
  service = each.key
}


module "vpc" {
  source              = "../modules/vpc"
  vpc_name            = "store-vpc"
  region              = var.region
  backend_subnet_cidr = "10.0.1.0/24"
  database_subnet_cidr = "10.0.2.0/24"
}

module "database" {
  source           = "../modules/database"
  db_instance_name = "store-sql-instance"
  region           = var.region
  project_id       = var.project_id
  vpc_name         = module.vpc.vpc_name
  db_user          = "app_user"
  db_password      = "ChangeMe123"
  db_name          = "app_db"
}

module "artifact_registry" {
  source     = "../modules/artifact_registry"
  region     = var.region
}

