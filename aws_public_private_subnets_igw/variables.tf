//vpc
variable "vpc_name" {
    default = "bmbvpc"
}

variable "vpc_cidr_block" {
    default = "192.168.0.0/16"
}


//subnets
variable "sub_priv_cidr" {
    default = "192.168.1.0/24"
}

variable "sub_pub_cidr" {
    default = "192.168.2.0/24"
}

variable "sub_pub_az" {
    default = "ap-south-1b"
}

variable "sub_priv_az" {
    default = "ap-south-1a"
}

//igw
variable "igw_name" {
    default = "bmbigw1"
}

//route
variable "route_table_name" {
    default = "bmbroutetb"
}

//instnaces
//database
variable "db_ami" {
    default = "ami-76166b19"
}

variable "db_instance_type" {
    default = "t2.micro"
}

variable "key_name" {
    default = "t3"
}

variable "db_instance_name" {
    default = "DB_Private"
}

//wordpress
variable "wp_instance_type" {
    default = "t2.micro"
}

variable "wp_instance_name" {
    default = "WordPress"
}

variable "wp_ami" {
    default = "ami-052c08d70def0ac62"
}