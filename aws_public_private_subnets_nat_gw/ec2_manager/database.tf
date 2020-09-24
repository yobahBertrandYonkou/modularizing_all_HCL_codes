variable "db_subnet_id" {}
variable "db_ami" {}
variable "db_instance_type" {}
variable "db_az" {}
variable "key_name" {}
variable "db_instance_name" {}

//launching database instance

resource "aws_instance" "bmbdbpriv" {
  ami = var.db_ami
  instance_type = var.db_instance_type
  subnet_id = var.db_subnet_id
  associate_public_ip_address = false
  availability_zone = var.db_az
  key_name = var.key_name

  tags = {
    "Name" = var.db_instance_name
  }
}