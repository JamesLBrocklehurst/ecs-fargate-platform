variable "app_name" {
  description = "Name of the application"
  type        = string
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