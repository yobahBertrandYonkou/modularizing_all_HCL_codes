provider "aws" {
    version = "~> 2.0"
    region = "ap-south-1"
    profile = "bmbterraform"
}

//keypair module
module "keypair" {
    source = "./keypair"
    keypair_name = var.keypair_name
}

//security group (sg)
module "security_group" {
    source = "./security group"
    sg_name = var.sg_name
    sg_desc = var.sg_desc
    sg_vpc_id = var.sg_vpc_id
    next = module.keypair.next
}

//launches and configures ec2 instance
module "webserver" {
    source = "./ec2 instance"
    instance_type = var.instance_type
    keypair_name = var.keypair_name
    sg_name = var.sg_name
    ami = var.ami
    instance_name = var.instance_name
    az_name = var.az_name
    next = module.security_group.next
}

//efs volume
module "efs_manager" {
    source = "./efs manager"
    next = module.webserver.next
    efs_name = var.efs_name
    key_path = var.key_path
    host_ip = module.webserver.host_ip
    subnet_id = module.webserver.subnet_id
    sg_name = var.sg_name
}

//s3 bucket
module "s3_bucket" {
    source = "./s3 bucket - upload"
    bucket_name = var.bucket_name
    access_ctrl_list = var.access_ctrl_list
    content_type = var.content_type
    content_dir = var. content_dir
    next = module.efs_manager.next
}

//cloudfront
module "cloudfront" {
    source = "./cloudfront"
    next = module.s3_bucket.next
    bucket_domain_name = module.s3_bucket.bucket_domain_name
}

//updating bucket policy
module "bucket_policy"{
    source = "./update bucket policy"
    bucket_arn = module.s3_bucket.bucket_arn
    bucket_id = module.s3_bucket.bucket_id
    origin_access_id_iam_arn = module.cloudfront.origin_access_id_iam_arn
    next = module.cloudfront.next
}

//updating webage url
module "webpage_url_upadate" {
    source = "./update url"
    next = module.bucket_policy.next
    host_ip = module.webserver.host_ip
    cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
    key_path = var.key_path
    default_url = var.default_url    
}

