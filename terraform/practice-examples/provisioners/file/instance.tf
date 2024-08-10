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

  connection {
    type     = "ssh"
    user     = "${var.instance_default_user}"
    private_key = file("${path.module}/keys/id_rsa.pem") // pass private key not a public key
    host     = "${self.public_ip}"   // self : referring to current resource block
  }                                 // public_ip : arg of aws instance resource



# transfer file or directory
  provisioner "file" {
    source      = "userdata.txt"
    destination = "/tmp/userdata.txt"
  }
# transfer content to file
  provisioner "file" {
    content      = "hello vishalk17"
    destination = "/tmp/vishalk17.log"
  }
}

### just an example how to print some output
output "user_data" {
  value = aws_instance.instance-1.user_data
}