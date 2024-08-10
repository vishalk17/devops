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

  connection {
    type        = "ssh"
    user        = var.instance_default_user
    private_key = file("${path.module}/keys/id_rsa.pem") // pass private key not a public key
    host        = self.public_ip                         // self : referring to current resource block
  }                                                      // public_ip : arg of aws instance resource

  # Installing nginx, tree and creating file ref.txt
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo yum install -y tree",
      "echo 'hello vishal' >> /tmp/ref.txt"
    ]
  }

  # Execute Script and continue even if it failed
  provisioner "remote-exec" {
    on_failure = continue
    script     = "nginx-service.sh"
  }

  # Backup re.txt to local where terraform running
  provisioner "local-exec" {
    when       = create
    on_failure = fail
    command    = "scp -i ${path.module}/keys/id_rsa.pem ${var.instance_default_user}@${self.public_ip}:/tmp/ref.txt . "
  }
}