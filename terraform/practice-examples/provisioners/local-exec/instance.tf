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

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > public_ip.txt" 
  }

  provisioner "local-exec" {
    environment = {
      "name" = "vishal"
    }
    command = "env > env.txt"  // we can export env variable like this
    }

  provisioner "local-exec" {
    working_dir = "/home"
    interpreter = [ "python3", "-c" ]  // can use different interpreter like this
    command = "print('hello vishal-chinu')"
  }
}

### just an example how to print some output
output "user_data" {
  value = aws_instance.instance-1.user_data
}