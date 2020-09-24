variable "vpc_id" {}
variable "sub_priv_cidr" {}
variable "sub_pub_cidr" {}
variable "sub_pub_az" {}
variable "sub_priv_az" {}

//create subnet
resource "aws_subnet" "subnetpriv"{
  vpc_id = var.vpc_id
  cidr_block = var.sub_priv_cidr
  availability_zone = var.sub_priv_az
  tags = {
    Name = "private_subnet"
  }
}

resource "aws_subnet" "subnetpub"{
  vpc_id = var.vpc_id
  cidr_block = var.sub_pub_cidr
  availability_zone = var.sub_pub_az
  tags = {
    Name = "public_subnet"
  }
}

output "subnetpub_id"{
  value = aws_subnet.subnetpub.id
}

output "subnetpriv_id"{
  value = aws_subnet.subnetpriv.id
}
