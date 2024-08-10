## main configuration of terraform ##

provider "github" {          // Using provider github to communicate with github
  token = var.github_token // for authentication with github
}

resource "github_repository" "first_repository_terraform" {
  name        = "first_repository_terraform" // telling the name of repo
  description = "My first repo"
  visibility  = "public"
  auto_init = true 
}

resource "github_repository" "second_repository_terraform" {
  name        = "second_repository_terraform"
  description = "My second repo"
  visibility  = "public"
  auto_init = true 
}
