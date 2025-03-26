# ------------------------------------- Apex Route 53 Records
resource "aws_route53_record" "www_A_record" {
  zone_id = var.zone_id
  name    = var.domain_name  # Your full domain, e.g., dev.example.com
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = "Z2FDTNDATAQYW2"  # CloudFront Zone ID (Always the same)
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_AAAA_record" {
  zone_id = var.zone_id
  name    = var.domain_name  # Your full domain, e.g., dev.example.com
  type    = "AAAA"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = "Z2FDTNDATAQYW2"  # CloudFront Zone ID (Always the same)
    evaluate_target_health = false
  }
}