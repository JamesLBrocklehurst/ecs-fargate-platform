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
