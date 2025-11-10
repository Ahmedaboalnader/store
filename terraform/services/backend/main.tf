module "backend" {
  source               = "../../modules/backend"
  region               = var.region
  project_id           = var.project_id
  service_name         = var.service_name
  image                = var.backend_image
  port_backend         = var.port_backend
  db_private_ip        = data.terraform_remote_state.infra.outputs.db_private_ip
  db_name              = data.terraform_remote_state.infra.outputs.db_name
  db_user              = data.terraform_remote_state.infra.outputs.db_user
  db_password          = var.db_password
  vpc_connector_id     = data.terraform_remote_state.infra.outputs.vpc_connector_id
  service_account_name = data.terraform_remote_state.infra.outputs.service_account_email
}

output "backend_url" {
  value = module.backend.backend_url
}

output "backend_service_name" {
  value = module.backend.backend_service_name
}