output "db_instance_connection_name" {
  description = "Cloud SQL instance connection name"
  value       = google_sql_database_instance.db_instance.connection_name
}

output "db_private_ip" {
  description = "Private IP address of the Cloud SQL instance"
  value       = google_sql_database_instance.db_instance.private_ip_address
}

# output "db_private_ip" {
#   value = google_sql_database_instance.main.private_ip_address
# }
output "connection_string" {
  value = "mysql://${google_sql_user.app_user.name}:${var.db_password}@${google_sql_database_instance.db_instance.connection_name}/${google_sql_database.app_database.name}"
  sensitive = true
}
