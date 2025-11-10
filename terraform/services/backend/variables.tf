variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "service_name" {
  type = string
}

variable "backend_image" {
  type = string
}

variable "port_backend" {
  type = number
  default = 5000
}

variable "db_private_ip" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "vpc_connector_id" {
  type = string
}

variable "service_account_email" {
  type = string
}
 
 



