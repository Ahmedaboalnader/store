variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}


# provider data


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

variable "connector_ip_cidr" {
  description = "CIDR range"
  type        = string
  default     = "10.0.3.0/28"
}