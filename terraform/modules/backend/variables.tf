variable "region" {
  description = "Deployment region"
  type        = string
}

variable "service_name" {
  description = "Cloud Run service name"
  type        = string
}

variable "image" {
  description = "Docker image for the backend"
  type        = string
}

variable "db_private_ip" {
  description = "Private IP of the Cloud SQL instance"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_user" {
  description = "Database user"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
variable "port-backend" {
  description = "The backend port"
  type        = string
} 

variable "vpc_connector_id" {
  type        = string
  description = "ID of the VPC connector to use for Cloud Run"
  default = ""

}



