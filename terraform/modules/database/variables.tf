variable "db_instance_name" {
  description = "Name of the Cloud SQL instance"
  type        = string
}

variable "region" {
  description = "Region where Cloud SQL will be deployed"
  type        = string
}

variable "tier" {
  description = "Machine type for the SQL instance"
  type        = string
  default     = "db-f1-micro"
}

variable "vpc_self_link" {
  description = "VPC self link for private IP"
  type        = string
}

variable "db_name" {
  description = "Application database name"
  type        = string
  default     = "app_db"
}

variable "db_user" {
  description = "Database username"
  type        = string
  default     = "app_user"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
variable "project_id" {}
variable "vpc_name" {}

