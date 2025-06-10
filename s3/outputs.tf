output "url" {
  description = "website URL"
  value       = "http://${aws_s3_bucket_website_configuration.website.website_endpoint}"
}

output "name" {
  description = "bucket name"
  value       = aws_s3_bucket.bucket.id
}