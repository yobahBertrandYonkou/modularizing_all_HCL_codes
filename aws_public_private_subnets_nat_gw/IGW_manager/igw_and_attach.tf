variable "vpc_id" {}
variable "igw_name" {}

//create IGW
resource "aws_internet_gateway" "igw1"{
  vpc_id = var.vpc_id
  
  tags = {
    Name = var.igw_name
  }
}

output "igw_id"{
  value = aws_internet_gateway.igw1.id
}