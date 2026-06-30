output "certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.main.arn
}

output "domain_validation_options" {
  description = "Domain validation options to create DNS validation records"
  value       = aws_acm_certificate.main.domain_validation_options
}

output "fqdn" {
  description = "The fully qualified domain name the certificate was issued for"
  value       = local.fqdn
}
