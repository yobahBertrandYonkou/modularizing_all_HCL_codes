variable "igw_id" {}
variable "vpc_id" {}
variable "route_table_name" {}
variable "subnetpub_id" {}

//create a route table and a route
resource "aws_route_table" "routetb1"{
  vpc_id = var.vpc_id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = var.route_table_name
  }
}


//associate subnet with route table
resource "aws_route_table_association" "rtbassoc1"{
  depends_on = [aws_route_table.routetb1]
  subnet_id = var.subnetpub_id
  route_table_id = aws_route_table.routetb1.id
}