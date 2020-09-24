variable "nat_id" {}
variable "nat_subnet_id" {}

//create a route table and a route
resource "aws_route_table" "natroutetb1"{
  vpc_id = var.vpc_id

  route{
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }

  tags = {
    Name = "bmbnatroutetb"
  }
}


//associate subnet with nat route table
resource "aws_route_table_association" "natrtbassoc1"{
  depends_on = [aws_route_table.natroutetb1]
  subnet_id = var.nat_subnet_id
  route_table_id = aws_route_table.natroutetb1.id
}