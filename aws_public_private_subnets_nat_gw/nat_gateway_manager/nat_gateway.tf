variable "nat_name" {}
variable "allocation_id" {}
variable "nat_subnet_id" {}

//creating nat-gateway
resource "aws_nat_gateway" "bmbnat"{
  allocation_id = var.allocation_id
  subnet_id = var.nat_subnet_id

  tags = {
    Name = var.nat_name
  }
}

output "nat_id" {
    value = aws_nat_gateway.bmbnat.id
}