# ref : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "instance-1" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type_md
  key_name      = var.instance_key_md

  tags = {
    Name = var.instance_name_md
  }
}   
