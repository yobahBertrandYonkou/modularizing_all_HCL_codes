//keypair variables
variable "keypair_name" {
    default = "webserver_key"
}

//sg group variables
variable "sg_name"{
    default = "http_sshd"
}

variable "sg_vpc_id"{
    default = "vpc-fe697596"
}

variable "sg_desc"{
    default = "Allows ssh and http"
}

//ec2 variables
variable "instance_type" {
    default = "t2.micro"
}
variable "ami" {
    default = "ami-0447a12f28fddb066"
}
variable "instance_name" {
    default = "Web-server"
}
variable "az_name" {
    default = "ap-south-1a"
}

//ebs variables
variable "ebs_name" {
    default = "webharddisk"
}

variable "key_path"{
    default = "C:\\Users\\YOBAH BERTRAND Y\\Desktop\\yob\\task5\\"
}

variable "volume_size" {
    type = number
    default = 1
}

variable "device_name" {
    default = "/dev/sdh"
}

//s3 bucket variables
variable "bucket_name" {
    default = "bmbvfx"
}

variable "access_ctrl_list" {
    default = "public-read"
}

variable "content_type" {
    default = "image/jpg"
}

variable "content_dir" {
    default = "C:/Users/YOBAH BERTRAND Y/Desktop/yob/task5/images/"
}

variable "default_url" {
    default = "cloudFrontUrl"
}

variable "snapshot_name" {
    default = "myos1_snapshot"
}