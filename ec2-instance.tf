# EC2
resource "aws_instance" "web" {
  ami                     = var.ami_id
  instance_type           = var.instance_type
  subnet_id               = aws_subnet.public_1.id
  # vpc_security_group_ids  = [vpc_security_group.allow_ssh.id]
  key_name                = var.key_name

  tags = {
    Name = "Ec2-with-VPC"
  }
}

# Security
