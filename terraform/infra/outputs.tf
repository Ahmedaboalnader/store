output "vpc_name" {
  value = module.vpc.vpc_name
}

output "db_private_ip" {
  value = module.database.db_private_ip
}

output "backend_repo" {
  value = module.artifact_registry.backend_repo
}

output "frontend_repo" {
  value = module.artifact_registry.frontend_repo
}
  

output "vpc_connector_id" {
  value = module.vpc.backend_connector_id
}
