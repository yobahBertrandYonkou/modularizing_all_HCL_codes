variable "instance_type" {}
variable "keypair_name" {}
variable "sg_name" {}
variable "ami" {}
variable "instance_name" {}
variable "az_name" {}
variable "next" {}
variable "key_path" {}

//creates a t2.micro instance, installs required softwares and starts some httpd service

resource "aws_instance" "myos1" {
    instance_type = var.instance_type
    key_name = var.keypair_name
    security_groups = [var.sg_name]
    ami = var.ami

//connects to instance via ssh
connection {
    type = "ssh"
    user = "ec2-user"
    host = aws_instance.myos1.public_ip
    private_key = file("${var.key_path}webserver_key.pem")
}

provisioner "remote-exec" {
    inline = [
    "sudo yum install git -y",
    "sudo yum install httpd -y",
    "sudo yum install php -y",
    "sudo systemctl start httpd",
    "sudo systemctl enable httpd"
    ]
}

    tags = {
    Name = var.instance_name
    }
}

output "ec2_instance_id" {
    value = aws_instance.myos1.id
}

output "host_ip" {
    value = aws_instance.myos1.public_ip
}

output "next" {
    value = "done"
}