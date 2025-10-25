output "vpc_name" {
  value = module.vpc.vpc_name
}

output "db_private_ip" {
  value = module.cloudsql.db_private_ip
}

output "backend_url" {
  value = module.backend.backend_url
}

output "frontend_url" {
  value = module.frontend.frontend_url
}
