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
}

variable "frontend_image" {
  description = "Docker image for the frontend"
  type        = string
}

variable "db_private_ip" {
  description = "Private IP of the database"
  type        = string
}


variable "VPC_CONNECTOR_ID" {
  description = "ID of the VPC connector"
  type        = string
}


variable "zone" {
  description = "GCP zone for resources"
  type        = string
  default     = "us-central1-a"
}
