terraform {
  backend "s3" {
   bucket = "migrated-backend"  // new s3 bucket
    key    = "terraform/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "vishalk17-terraform-table"
  }
}