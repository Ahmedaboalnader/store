variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "service_name" {
  type = string
}

variable "frontend_image" {
  type = string
}

variable "port_frontend" {
  type = number
  default = 80
}

variable "backend_url" {
  type = string
}
