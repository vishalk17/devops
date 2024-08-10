auth = {
  access_key = "your-access-key"
  secret_key = "your-secret-key"
}

ami                   = "ami-068e0f1a600cd311c"
instance_name         = "amz-linux-2023"
instance_type         = "t2.micro"
instance_default_user = "ec2-user"
region                = "ap-south-1"
ports_list            = [80, 22, 9090]