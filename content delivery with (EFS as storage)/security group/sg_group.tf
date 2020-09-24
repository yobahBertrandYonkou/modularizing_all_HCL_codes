variable "sg_name" {}
variable "sg_desc" {}
variable "sg_vpc_id" {}
variable "next" {}

//creates a security group that allows ssh and http ports for inbound traffic
//and all outbound traffics
resource "aws_security_group" "http_ssh" {
    name = var.sg_name
    description = var.sg_desc
    vpc_id = var.sg_vpc_id

egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress{
  description  = "allows NFS"
  from_port = 2049
  to_port = 2049
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

    tags = {
    Name = var.sg_name
    }
}

output "next" {
    value = "done"
}