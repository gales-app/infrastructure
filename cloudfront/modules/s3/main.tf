# Create S3 Bucket for React app files
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = merge(
    {
      Name = var.bucket_name
    },
    var.default_tags,
  )
}

# Configure bucket versioning
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Configure bucket lifecycle
resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "delete_noncurrent_versions_after_90_days"
    status = "Enabled"

    filter {
      prefix = ""  // Empty prefix applies to all objects
      // Or specify a specific prefix like "documents/"
    }

    expiration {
      days = 90 # Delete non-current versions after 90 days
    }
  }
}

# Block public access to the S3 bucket (recommended security practice)
resource "aws_s3_bucket_public_access_block" "block_all_public_access" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "index" {
  count = var.deploy_default_index ? 1 : 0
  
  bucket       = aws_s3_bucket.bucket.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/index.html")
}

