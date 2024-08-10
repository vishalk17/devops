data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
  filter {
    name   = "owner-id"
    values = ["137112412989"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

// argument for id :  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami#attribute-reference
output "aws_ami_id" {
  value = data.aws_ami.amazon_linux_2023.id
}