module "backend" {
  source                = "../../modules/backend"
  region                = var.region
  project_id            = var.project_id
  service_name          = var.service_name
  image                 = var.backend_image
  port_backend          = var.port_backend
  db_private_ip         = var.db_private_ip
  db_name               = var.db_name
  db_user               = var.db_user
  db_password           = var.db_password
  vpc_connector_id      = var.vpc_connector_id
  service_account_name  = var.service_account_email
}

output "backend_url" {
  value = module.backend.backend_url
}

output "backend_service_name" {
  value = module.backend.backend_service_name
}
