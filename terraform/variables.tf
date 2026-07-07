variable "app_name" {
  description = "Name of the application, used as a prefix/tag for created resources"
  type        = string
}

variable "encryption_type" {
  description = "The encryption type for the ECR repository"
  type        = string
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
  description = "The AWS region resources are deployed in"
  type        = string
}

variable "desired_count" {
  description = "The number of ECS task instances to run"
  type        = number
}

variable "github_username" {
  description = "GitHub username for the repository"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}