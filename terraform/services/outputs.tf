output "backend_url" {
  value = module.backend.backend_url
}

output "frontend_url" {
  value = module.frontend.frontend_url
}

output "vpc_connector_id" {
  value = module.vpc.backend_connector_id
}
