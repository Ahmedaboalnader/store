variable "project_id" {
  type    = string
  default = "konecta-task-467513"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "backend_image" {
  description = "Docker image for the backend"
  type        = string
  default     = null
}

variable "frontend_image" {
  description = "Docker image for the frontend"
  type        = string
  default     = null
}

variable "db_private_ip" {
  description = "Private IP of the database"
  type        = string
  default     = null
}



variable "vpc_connector_id" {
  description = "ID of the VPC connector"
  type        = string
  default     = null
}



variable "zone" {
  description = "GCP zone for resources"
  type        = string
  default     = "us-central1-a"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = null
}

variable "db_user" {
  description = "Database user"
  type        = string
  default     = null
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  default     = null
}
