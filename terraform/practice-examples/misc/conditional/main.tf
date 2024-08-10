# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = lookup(var.auth, "access_key")
  secret_key = lookup(var.auth, "secret_key")
}

variable "region" {
  type = string
}

variable "auth" {
  type = map(any)
}

variable "amz-linux-ami" {
    description = "This AMI for Production"
    default = "ami-0a4408457f9a03be3"
}

variable "ubuntu-ami" {
    description = "This AMI for Development"
    default = "ami-0ad21ae1d0696ad58"
}

variable "setup_prod_env" {
  type        = string
  description = "Setup production env? (y/n)"
}

// lower: Converts a string to lowercase.
resource "aws_instance" "vishalk17-server" {
  ami           = lower(var.setup_prod_env) == "y" ? var.amz-linux-ami : var.ubuntu-ami
  instance_type = "t2.micro"
  tags = {
    Name = "vishalk17-server"
  }
}