variable "project_id" {
  description = "GCP project ID"
  type        = string
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
