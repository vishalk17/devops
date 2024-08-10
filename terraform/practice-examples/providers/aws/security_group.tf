resource "aws_security_group" "SG_vishal" {
  name        = "SG_vishal"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "SG_vishal"
  }

  dynamic "ingress" {
    for_each = var.ports_list
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  }

  # Allow all outbound rules
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}