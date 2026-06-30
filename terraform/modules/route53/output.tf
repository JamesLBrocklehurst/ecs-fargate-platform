output "zone_id" {
  description = "The Route53 hosted zone ID"
  value       = data.aws_route53_zone.main.zone_id
}

output "validated_certificate_arn" {
  description = "The ARN of the validated ACM certificate"
  value       = aws_acm_certificate_validation.main.certificate_arn
}
