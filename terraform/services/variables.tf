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

variable "DATABASE_IP" {
  default = data.terraform_remote_state.infra.outputs.db_private_ip
}

variable "VPC_CONNECTOR_ID" {
  default = data.terraform_remote_state.infra.outputs.backend_connector_id
}

variable "zone" {
  description = "GCP zone for resources"
  type        = string
  default     = "us-central1-a"
}
