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
variable "port_backend" {
  description = "The backend port"
  type        = number
}

variable "ingress" {
  description = "Ingress type: internal or all"
  type        = string
  default     = "INGRESS_TRAFFIC_INTERNAL_ONLY"
}

variable "vpc_connector" {
  description = "Optional VPC Connector for Cloud Run"
  type        = string
  default     = ""
}

variable "min_instances" {
  description = "Minimum number of instances"
  type        = number
  default     = 1
}

variable "max_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 3
}

