variable "wp_instance_type" {}
variable "wp_instance_name" {}
variable "wp_az" {}
variable "wp_subnet_id" {}
variable "wp_ami" {}


//launching wordpress
resource "aws_instance" "wordpress" {
  ami = var.wp_ami
  instance_type = var.wp_instance_type
  subnet_id = var.wp_subnet_id
  availability_zone = var.wp_az
  key_name = var.key_name
  associate_public_ip_address = true
  
  connection {
    type = "ssh"
    user = "ec2-user"
    host = aws_instance.wordpress.public_ip
    private_key = file("C:\\Users\\YOBAH BERTRAND Y\\Desktop\\t3.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install php-mysqlnd php-fpm httpd tar curl php-json -y",
      "sudo yum install php -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo curl https://wordpress.org/latest.tar.gz --output wordpress.tar.gz",
      "sudo tar xf wordpress.tar.gz",
      "sudo cp -r wordpress /var/www/html",
      "sudo setenforce 0"
    ]
  }


  tags = {
    "Name" = var.wp_instance_name
  }
}