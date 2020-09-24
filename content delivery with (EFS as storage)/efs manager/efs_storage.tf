variable "efs_name" {}
variable "key_path" {}
variable "host_ip" {}
variable "next" {}
variable "subnet_id" {}
variable "sg_name" {}


//creates efs storage
resource "aws_efs_file_system" "efs_storage"{
  creation_token = var.efs_name
  tags = {
    Name = var.efs_name
  }
}//closses efs storage

//creates a mount target for efs_storage
resource "aws_efs_mount_target" "alpha" {
  depends_on = [aws_efs_file_system.efs_storage]
  file_system_id = aws_efs_file_system.efs_storage.id
  subnet_id      = var.subnet_id
  security_groups = [var.sg_name]
}


resource "null_resource" "mounts_efs" {
  depends_on = [aws_efs_mount_target.alpha]
  //connects  to ec2 instance
  connection{
    type = "ssh"
    user = "ec2-user"
    host = var.host_ip
    private_key = file("${var.key_path}webserver_key.pem")
  }

    //installs nfs util
    provisioner "remote-exec"{
      inline = [
        "sudo yum install git -y",
        "sudo yum install httpd -y",
        "sudo yum install php -y",
        "sudo systemctl start httpd",
        "sudo systemctl enable httpd",
        "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs_storage.dns_name}:/ /var/www/html",
        "sudo df -h",
        "sudo rm -rf /var/www/html/*",
        "sudo git clone --single-branch --branch master https://github.com/yobahBertrandYonkou/hmctask1.git  /var/www/html"
      ]
    }
}



output "next"{
    value = "done"
}
