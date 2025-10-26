# module "vpc" {
#   source              = "./modules/vpc"
#   vpc_name            = "store-vpc"
#   region              = "us-central1"
#   backend_subnet_cidr = "10.0.1.0/24"
#   database_subnet_cidr = "10.0.2.0/24"
# }

# module "cloudsql" {
#   source          = "./modules/database"
#   db_instance_name = "store-sql-instance"
#   region           = "us-central1"
#   vpc_self_link    = module.vpc.vpc_name
#   db_password      = "ChangeMe123"
#   project_id = var.project_id
# vpc_name   = module.vpc.vpc_name

# }

# module "backend" {
#   source        = "./modules/backend"
#   region        = "us-central1"
#   service_name  = "store-backend"
#   image         = "us-central1-docker.pkg.dev/konecta-task-467513/backend-repo/store-backend:latest"
#   port-backend = "5000"
#   db_private_ip = module.cloudsql.db_private_ip
#   db_name       = "app_db"
#   db_user       = "app_user"
#   db_password   = "ChangeMe123"
# }

# module "frontend" {
#   source        = "./modules/frontend"
#   region        = "us-central1"
#   service_name  = "store-frontend"
#   image         = "us-central1-docker.pkg.dev/konecta-task-467513/frontend-repo/store-frontend:latest"
#   backend_url   = module.backend.backend_url
#   port-frontend = "80"
# }
