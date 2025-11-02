output "db_instance_connection_name" {
  description = "Cloud SQL instance connection name"
  value       = google_sql_database_instance.db_instance.connection_name
}

output "db_private_ip" {
  description = "Private IP of the SQL instance"
  value       = google_sql_database_instance.db_instance.private_ip_address
}
# output "db_private_ip" {
#   value = google_sql_database_instance.main.private_ip_address
# }
