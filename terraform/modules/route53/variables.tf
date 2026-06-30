variable "domain_name" {
  description = "The root domain name of the Route53 hosted zone"
  type        = string
}

variable "acm_validation_options" {
  description = "The domain_validation_options output from the ACM module, used to create DNS validation records"
  type = set(object({
    domain_name           = string
    resource_record_name  = string
    resource_record_type  = string
    resource_record_value = string
  }))
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate to validate"
  type        = string
}

variable "record_name" {
  description = "The name of the record to create for the ALB alias (e.g. the subdomain or root domain). Defaults to the root domain."
  type        = string
  default     = ""
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB, used as the alias target"
  type        = string
}

variable "alb_zone_id" {
  description = "The hosted zone ID of the ALB, used as the alias target"
  type        = string
}
