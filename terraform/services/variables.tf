variable "project_id" {
  description = "GCP project ID"
  type        = string
  default = "konecta-task-467513"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "vpc_name" {
  description = "Name for the VPC network"
  type        = string
  default     = "serverless-shop-vpc"
}

variable "db_password" {
  description = "Password for DB user (sensitive)"
  type        = string
  sensitive   = true
}

variable "db_private_ip" {
  description = "Private IP of the Cloud SQL database"
  type        = string
}


