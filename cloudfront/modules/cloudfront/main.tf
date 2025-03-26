# ------------------------------------- Apex domain CloudFront distribution

# Create an Origin Access Control (OAC) to restrict access to the S3 Bucket (required for CloudFront)
resource "aws_cloudfront_origin_access_control" "apex_oac" {
  name                              = "${var.environment}-oac"
  description                       = "OAC for accessing ${var.bucket_name} via CloudFront"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "apex_distribution" {
  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = var.bucket_name
    origin_access_control_id = aws_cloudfront_origin_access_control.apex_oac.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases             = [var.domain_name]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_name

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn       = var.acm_certificate_arn
    ssl_support_method        = "sni-only"
    minimum_protocol_version  = "TLSv1.2_2021"
  }

   # Add these custom error responses to redirect all 404s to index.html
  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }
  
  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  tags = merge(
    {
      Name = "${var.environment}-cloudfront"
    },
    var.default_tags,
  )
}