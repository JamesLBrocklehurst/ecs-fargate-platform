variable "app_name" {
  type = string
}

variable "encryption_type" {
  type = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnets with CIDR and AZ"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnets with CIDR and AZ"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "nat_gateway_subnet" {
  description = "Key of the public subnet to place the NAT Gateway in"
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

variable "task_cpu" {
  description = "The number of CPU units to reserve for the Fargate task"
  type        = number
}

variable "task_memory" {
  description = "The amount of memory (MiB) to reserve for the Fargate task"
  type        = number
}

variable "container_image" {
  description = "The container image (including tag) to run, e.g. the ECR repository URL"
  type        = string
}

variable "container_port" {
  description = "The port the container listens on"
  type        = number
}

variable "aws_region" {
  description = "The AWS region the ECS service is deployed in, used for the awslogs log driver"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC the ECS tasks will be deployed into"
  type        = string
}

variable "alb_security_group_id" {
  description = "The ID of the ALB security group, allowed to send traffic to the ECS tasks"
  type        = string
}

variable "desired_count" {
  description = "The number of ECS task instances to run"
  type        = number
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to place the ECS tasks in"
  type        = list(string)
}

variable "target_group_arn" {
  description = "The ARN of the ALB target group to register ECS tasks with"
  type        = string
}