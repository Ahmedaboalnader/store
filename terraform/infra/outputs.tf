output "vpc_name" {
  value = module.vpc.vpc_name
}

output "db_private_ip" {
  value = module.database.db_private_ip
}


output "vpc_connector_id" {
  value = google_vpc_access_connector.cloud_run_connector.id
}
output "backend_connector_id" {
  value = google_vpc_access_connector.cloud_run_connector.id
}

output "backend_repo" {
  value = module.artifact_registry.backend_repo
}

output "frontend_repo" {
  value = module.artifact_registry.frontend_repo
}

output "db_connection_string" {
  value     = module.database.connection_string
  sensitive = true
}





# output "vpc_name" {
#   value = module.vpc.vpc_name
# }

# # output "db_private_ip" {
# #   value = module.database.db_private_ip
# # }
# output "database_private_ip" {
#   description = "Private IP address of the Cloud SQL instance"
#   value       = module.database.db_private_ip
# }


# output "backend_repo" {
#   value = module.artifact_registry.backend_repo
# }

# output "frontend_repo" {
#   value = module.artifact_registry.frontend_repo
# }
  
# output "vpc_connector_id" {
#   value = google_vpc_access_connector.cloud_run_connector.id
# }


