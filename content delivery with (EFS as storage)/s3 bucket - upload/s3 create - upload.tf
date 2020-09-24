variable "bucket_name" {}
variable "access_ctrl_list" {}
variable "content_type" {}
variable "content_dir" {}
variable "next" {}

//creates an s3 bucket
resource "aws_s3_bucket" "cf_bucket" {
  bucket = var.bucket_name
  acl    = var.access_ctrl_list

  tags = {
    Name = var.bucket_name
  }
}

//uploads all images to s3 bucket
resource "aws_s3_bucket_object" "upload_images" {
depends_on = [ aws_s3_bucket.cf_bucket ]
  for_each = fileset("${var.content_dir}", "**/**.jpg")
  force_destroy = true
  content_type = var.content_type
  bucket = aws_s3_bucket.cf_bucket.bucket
  key    = each.value
  source = "${var.content_dir}/${each.value}"
}

output "next" {
    value = "done"
}

output "bucket_arn" {
    value = aws_s3_bucket.cf_bucket.arn
}

output "bucket_id" {
    value = aws_s3_bucket.cf_bucket.id
}

output "bucket_domain_name" {
    value = aws_s3_bucket.cf_bucket.bucket_regional_domain_name
}