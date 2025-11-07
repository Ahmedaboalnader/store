
output "frontend_url" {
  value = module.frontend.frontend_url
}

output "backend_url" {
  value = module.backend.backend_url
}

output "backend_service_name" {
  value = module.backend.backend_service_name
}

variable "DATABASE_IP" {
  description = "Private IP of the database"
  type        = string
}

variable "db_private_ip" {
  description = "Private IP of the database"
  type        = string
}
