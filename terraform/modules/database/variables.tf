variable "db_instance_name" { type = string }
variable "region" { type = string }
variable "project_id" { type = string }
variable "vpc_name" { type = string }
variable "db_name" { type = string }
variable "db_user" { type = string }
variable "db_password" { type = string }

variable "vpc_self_link" {
  description = "VPC self_link to attach Cloud SQL private network"
  type        = string
}
