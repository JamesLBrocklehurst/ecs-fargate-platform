# ACM Certificate

locals {
  fqdn = var.subdomain != "" ? "${var.subdomain}.${var.domain_name}" : var.domain_name
}

resource "aws_acm_certificate" "main" {
  domain_name       = local.fqdn
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

# Tags

  tags = {
    Name        = "${var.app_name}-acm-cert"
    Terraform   = "true"
    Environment = "production"
  }
}
