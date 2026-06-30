variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC the ALB will be deployed into"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to attach the ALB to"
  type        = list(string)
}

variable "certificate_arn" {
  description = "The ARN of the validated ACM certificate for the HTTPS listener"
  type        = string
}

variable "target_port" {
  description = "The port the target group forwards traffic to on the ECS tasks"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "The path the target group health check requests"
  type        = string
  default     = "/"
}
