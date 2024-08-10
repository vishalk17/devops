# ref : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "instance-1" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "instance_key"

  # vpc_security_group_ids attribute expects a list of security group IDs, 
  # so we need to pass it as a list [...] instead of a string "..."
  vpc_security_group_ids = [aws_security_group.SG_vishal.id]

  tags = {
    Name = "${var.instance_name}"
  }

 # user_data = file("${path.module/userdata.txt}")
  user_data = file("${path.module}/userdata.txt")
}

### just an example how to print some output
output "user_data" {
  value = aws_instance.instance-1.user_data
}