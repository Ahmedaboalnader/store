module "backend" {
  source        = "./modules/backend"
  region        = "us-central1"
  service_name  = "store-backend"
  image         = "us-central1-docker.pkg.dev/konecta-task-467513/backend-repo/store-backend:latest"
  port-backend = "5000"
  db_private_ip = module.cloudsql.db_private_ip
  db_name       = "app_db"
  db_user       = "app_user"
  db_password   = "ChangeMe123"
} 

module "frontend" {
  source        = "./modules/frontend"
  region        = "us-central1"
  service_name  = "store-frontend"
  image         = "us-central1-docker.pkg.dev/konecta-task-467513/frontend-repo/store-frontend:latest"
  backend_url   = module.backend.backend_url
  port-frontend = "80"
}
