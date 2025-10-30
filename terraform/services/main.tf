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
  vpc_connector = "projects/konecta-task-467513/locations/us-central1/connectors/store-vpc-connector"
} 

module "frontend" {
  source        = "../modules/frontend"
  region        = "us-central1"
  service_name  = "store-frontend"
  image         = "us-central1-docker.pkg.dev/konecta-task-467513/frontend-repo/store-frontend:latest"
  backend_url   = module.backend.backend_url
  port_frontend = 80
}
