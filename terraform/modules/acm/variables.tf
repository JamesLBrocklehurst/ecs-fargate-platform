variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "domain_name" {
  description = "The root domain name to create the certificate for"
  type        = string
}

variable "subdomain" {
  description = "Optional subdomain to prepend to the domain name (e.g. \"app\" for app.example.com). Leave empty to use the root domain only."
  type        = string
  default     = ""
}
