data "terraform_remote_state" "infra" {
  backend = "remote"
  config = {
    organization = "ahmedaboalnder"
    workspaces = {
      name = "my-infra"
    }
  }
}
