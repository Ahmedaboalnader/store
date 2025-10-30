variable "region" {
  description = "Deployment region"
  type        = string
}

variable "service_name" {
  description = "Frontend Cloud Run service name"
  type        = string
}

variable "image" {
  description = "Docker image for the frontend"
  type        = string
}

variable "backend_url" {
  description = "The backend URL for API communication"
  type        = string
}
variable "port_frontend" {
  description = "The frontend port"
  type        = number
}