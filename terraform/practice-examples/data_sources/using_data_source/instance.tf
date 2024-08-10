# ref : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "instance-1" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  key_name      = "instance_key"

  tags = {
    Name = "${var.instance_name}"
  }
}