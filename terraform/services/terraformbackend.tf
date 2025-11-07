terraform {
  cloud {
    organization = "ahmedaboalnder"
    workspaces {
      name = "services"
    }
  }
}
