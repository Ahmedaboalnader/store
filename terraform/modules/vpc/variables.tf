variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "region" {
  description = "Region where the resources will be created"
  type        = string
  default     = "us-central1"
}

variable "backend_subnet_cidr" {
  description = "CIDR range for backend subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "database_subnet_cidr" {
  description = "CIDR range for database subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "connector_ip_cidr" {
  description = "CIDR range for Serverless VPC Access connector (must not overlap with subnets)"
  type        = string
  default     = "10.0.3.0/28"
}
