# Route53 Hosted Zone

data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

# DNS Validation Records for ACM Certificate

resource "aws_route53_record" "acm_validation" {
  for_each = {
    for option in var.acm_validation_options : option.domain_name => option
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 60
}

# Wait for ACM Certificate Validation

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = var.certificate_arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}
