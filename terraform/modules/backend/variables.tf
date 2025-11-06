variable "service_name" {}
variable "region" {}
variable "image" {}
variable "port_backend" { type = number }

variable "db_private_ip" {}
variable "db_name" {}
variable "db_user" {}
variable "db_password" { sensitive = true }

variable "vpc_connector_id" {}
variable "service_account_name" {}
variable "project_id" {
  type = string
}

