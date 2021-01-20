resource "aws_s3_bucket" "backend_bucket" {
  bucket = "${local.resource_prefix}infrastructure-tf-state"
  acl = "private"

  versioning {
    enabled = true
  }

  tags = merge(local.common_tags, {
    tf-backend = true
  })
}

output "bucket_name" {
  value = aws_s3_bucket.backend_bucket.bucket
}