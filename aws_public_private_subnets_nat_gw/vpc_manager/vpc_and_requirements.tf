variable "vpc_name" {}
variable "vpc_cidr_block" {}

//create a vpc
resource "aws_vpc" "bmbvpc"{
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

//security group
resource "aws_default_security_group" "default" {
  depends_on = [aws_vpc.bmbvpc]
  vpc_id      = aws_vpc.bmbvpc.id

  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "default"
  }
}

output "vpc_id" {
    value = aws_vpc.bmbvpc.id
}