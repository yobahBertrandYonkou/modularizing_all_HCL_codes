variable "ebs_name" {}
variable "az_name" {}
variable "volume_size" {}
variable "device_name" {}
variable "ec2_instance_id" {}
variable "key_path" {}
variable "host_ip" {}
variable "next" {}



//creates a volume
resource "aws_ebs_volume" "webvolume" {
    availability_zone = var.az_name
    size = var.volume_size

    tags = {
    Name = var.ebs_name
    }
}


//attaches the volume created above to the instance above
resource "aws_volume_attachment" "webvol_att" {
    depends_on = [aws_ebs_volume.webvolume ]
    device_name = var.device_name
    instance_id = var.ec2_instance_id
    volume_id = aws_ebs_volume.webvolume.id
    force_detach = true

//connects to instance
connection {
    type = "ssh"
    user = "ec2-user"
    host = var.host_ip
    private_key = file("${var.key_path}webserver_key.pem")
}

//mounts attached volume
provisioner "remote-exec" {
    inline = [
    "sudo mkfs.ext4 ${var.device_name}",
    "sudo mount ${var.device_name} /var/www/html",
    "sudo rm -rf /var/www/html/*",
    "sudo git clone --single-branch --branch master https://github.com/yobahBertrandYonkou/hmctask1.git  /var/www/html"
    ]
}
}

output "next"{
    value = "done"
}

output "ebs_volume_id" {
    value = aws_ebs_volume.webvolume.id
}