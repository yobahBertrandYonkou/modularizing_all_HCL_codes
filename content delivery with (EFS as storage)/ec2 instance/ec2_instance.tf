variable "instance_type" {}
variable "keypair_name" {}
variable "sg_name" {}
variable "ami" {}
variable "instance_name" {}
variable "az_name" {}
variable "next" {}

//creates a t2.micro instance, installs required softwares and starts some httpd service

resource "aws_instance" "myos1" {
    instance_type = var.instance_type
    key_name = var.keypair_name
    security_groups = [var.sg_name]
    ami = var.ami

    tags = {
    Name = var.instance_name
    }
}

output "subnet_id" {
    value = aws_instance.myos1.subnet_id
}

output "host_ip" {
    value = aws_instance.myos1.public_ip
}

output "next" {
    value = "done"
}