terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "ahmedaboalnder"
    workspaces {
      name = "services"
    }
  }
}
