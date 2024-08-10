# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = lookup(var.auth, "access_key")
  secret_key = lookup(var.auth, "secret_key")
}