module "vpc" {
  source = "../modules/vpc"
  region = "us-central1"
  vpc_name = "store-vpc"
  backend_subnet_cidr = "10.0.2.0/24"
  database_subnet_cidr = "10.0.3.0/24"
}

data "terraform_remote_state" "infra" {
  backend = "local"
  config = {
    path = "../infra/terraform.tfstate"
  }
}

module "backend" {
  source        = "../modules/backend"
  region        = "us-central1"
  service_name  = "store-backend"
  image         = "us-central1-docker.pkg.dev/konecta-task-467513/backend-repo/store-backend:latest"
  port_backend = 5000
  db_private_ip = "10.88.0.3"
  db_name       = "app_db"
  db_user       = "app_user"
  db_password   = "ChangeMe123"
  # project_id    = "konecta-task-467513"
  vpc_connector_id = data.terraform_remote_state.infra.outputs.vpc_connector_id

  }



module "frontend" {
  source        = "../modules/frontend"
  region        = "us-central1"
  service_name  = "store-frontend"
  image         = "us-central1-docker.pkg.dev/konecta-task-467513/frontend-repo/store-frontend:latest"
  backend_url   = module.backend.backend_url
  port_frontend = 80
}
