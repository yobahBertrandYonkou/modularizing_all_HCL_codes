provider "aws" {
    version = "~> 2.0"
    region = "ap-south-1"
    profile = "bmbterraform"
}

//creating a vpc
module "vpc_creation" {
    source = "./vpc_manager"
    vpc_name = var.vpc_name
    vpc_cidr_block = var.vpc_cidr_block    
}

//subnets
module "priv_pub_subnets" {
    source = "./subnet_manager"
    vpc_id = module.vpc_creation.vpc_id
    sub_priv_cidr = var.sub_priv_cidr
    sub_pub_cidr = var.sub_pub_cidr
    sub_pub_az = var.sub_pub_az
    sub_priv_az = var.sub_priv_az
}

//igw
module "internet_gateway"{
    source = "./IGW_manager"
    vpc_id = module.vpc_creation.vpc_id
    igw_name = var.igw_name
}

//nat_gatway
module "nat_gateway" {
    source = "./nat_gateway_manager"
    nat_name = var.nat_name
    allocation_id = var.allocation_id
    nat_subnet_id = module.priv_pub_subnets.subnetpub_id    
}

//route
module "route_configurations" {
    source = "./route_manager"
    igw_id = module.internet_gateway.igw_id
    vpc_id = module.vpc_creation.vpc_id
    route_table_name = var.route_table_name
    subnetpub_id = module.priv_pub_subnets.subnetpub_id

    nat_id = module.nat_gateway.nat_id
    nat_subnet_id = module.priv_pub_subnets.subnetpriv_id
}

//database and wordpress
module "data_word" {
    source = "./ec2_manager"
    db_subnet_id = module.priv_pub_subnets.subnetpriv_id
    db_ami = var.db_ami
    db_instance_type = var.db_instance_type
    db_az = var.sub_priv_az
    key_name = var.key_name
    db_instance_name = var.db_instance_name

    wp_instance_type = var.wp_instance_type
    wp_instance_name = var.wp_instance_name
    wp_az = var.sub_pub_az
    wp_subnet_id = module.priv_pub_subnets.subnetpub_id
    wp_ami = var.wp_ami
}