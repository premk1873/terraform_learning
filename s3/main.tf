resource "aws_s3_bucket" "bucket" {
  bucket = "prem-karad-aws-terraform-1873"
}

resource "aws_s3_bucket_versioning" "ver" {
    bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ssec" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "rules" {
    bucket = aws_s3_bucket.bucket.id
  rule {
    id = "rule1"
    status = "Enabled"
    filter {
      
    }

    transition {
      days = 30
      storage_class = "ONEZONE_IA"
    }
    expiration {
      days = 90
    }
    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class = "STANDARD_IA"
    }
    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}

resource "aws_s3_bucket_public_access_block" "access_block" {
    bucket = aws_s3_bucket.bucket.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}