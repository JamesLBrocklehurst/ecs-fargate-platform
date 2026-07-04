output "ecr_repository_url" {
  description = "The URI of the ECR repository to push container images to"
  value       = module.ecr.repository_url
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "app_url" {
  description = "The URL the application is reachable at"
  value       = "https://${module.acm.fqdn}"
}

output "certificate_arn" {
  description = "The ARN of the validated ACM certificate"
  value       = module.route53.validated_certificate_arn
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = module.ecs.service_name
}
