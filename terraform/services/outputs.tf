output "backend_url" {
  value = module.backend.backend_url
}

output "frontend_url" {
  value = module.frontend.frontend_url
}

output "vpc_connector_id" {
  # module.vpc is not declared in this root module. If you add a VPC module that
  # exposes `backend_connector_id`, restore this output. For now return an
  # empty string to avoid validation errors.
  value = ""
}
