variable "next" {}

variable "bucket_domain_name" {}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "timeout 120"
  }
}
//sets s3 bucket id to be used when creating a cloudFront destribution
locals {
  s3_origin_id = "S3-bmbvfx"
}

//creates an origin acess indetity for cf
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  depends_on = [null_resource.delay]
  comment = "let_me_pass"
}

//creates a cloudFront distribution
resource "aws_cloudfront_distribution" "cloud_front_dist" {
  depends_on = [aws_cloudfront_origin_access_identity.origin_access_identity]
  origin {
    domain_name = var.bucket_domain_name
    origin_id   = local.s3_origin_id

    
      s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }


  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["DE"]
    }
  }

  tags = {
    env = "testing"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "next" {
    value = "done"
}

output "origin_access_id_iam_arn" {
    value = aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cloud_front_dist.domain_name
}