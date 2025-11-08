module "frontend" {
  source        = "../../modules/frontend"
  service_name  = var.service_name
  region        = var.region
  image         = var.frontend_image
  port_frontend = var.port_frontend
  backend_url   = var.backend_url
}

output "frontend_url" {
  value = module.frontend.frontend_url
}
