terraform {
  required_version = ">= 1.9.3" // Compatible with this version or higher than this

    required_providers {
    aws = {
      source  = "hashicorp/aws"
// ~> 5.0 allows versions such as 5.0.1, 5.1.0, or 5.9.9, but not 6.0.0 (major version ) or any later version.
      version = "~> 5.0"
    }
  }
}