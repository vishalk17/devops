resource "aws_key_pair" "instance_key" {
  key_name   = "aws_instance_key"
  public_key = file("${path.module}/keys/id_rsa.pem.pub")
}