resource "aws_s3_bucket" "bucket" {
  bucket = "prem-karad-aws-terraform-1873"
}

resource "aws_s3_bucket_versioning" "ver" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode(
        {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "PublicReadForWebsiteHosting",
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::prem-karad-aws-terraform-1873/*"
        }
      ]
    }
  )
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "index.html"
  source       = "website/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "styles" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "styles.css"
  source       = "website/styles.css"
  content_type = "text/css"
}

resource "aws_s3_object" "script" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "script.js"
  source       = "website/script.js"
  content_type = "text/javascript"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "error.html"
  source       = "website/error.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}