variable "next" {}
variable "ebs_volume_id" {}
variable "snapshot_name" {}

//creates snapshot of ebs_volume
resource "aws_ebs_snapshot" "myos1_snapshot" {
  volume_id = var.ebs_volume_id

  tags = {
    Name = var.snapshot_name
  }
}