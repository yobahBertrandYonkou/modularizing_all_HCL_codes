variable "bucket_arn" {}
variable "bucket_id" {}
variable "origin_access_id_iam_arn" {}
variable "next" {}


//updating bucket policy
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [var.origin_access_id_iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [var.bucket_arn]

    principals {
      type        = "AWS"
      identifiers = [var.origin_access_id_iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bmbvfx_policy" {
  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.s3_policy.json
}

output "next" {
    value = "done"
}