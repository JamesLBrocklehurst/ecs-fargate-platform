# ECR module

module "ecr" {
  source = "./modules/ecr"
  app_name = var.app_name
  encryption_type = var.encryption_type
}

# VPC module

module "vpc" {
  source = "./modules/vpc"
  app_name = var.app_name
  vpc_cidr = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  nat_gateway_subnet = var.nat_gateway_subnet
}

# ACM module

module "acm" {
  source = "./modules/acm"
  app_name = var.app_name
  domain_name = var.domain_name
  subdomain = var.subdomain
}

# Route53 module

module "route53" {
  source = "./modules/route53"
  domain_name = var.domain_name
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
  acm_validation_options = module.acm.domain_validation_options
  certificate_arn = module.acm.certificate_arn
  record_name = "${var.subdomain}.${var.domain_name}"
}

# ALB module

module "alb" {
  source = "./modules/alb"
  app_name = var.app_name
  vpc_id = module.vpc.vpc_id
  certificate_arn = module.route53.validated_certificate_arn
  public_subnet_ids = module.vpc.public_subnet_ids
  target_port = var.target_port
  health_check_path = var.health_check_path
}

# ECS module

module "ecs" {
  source = "./modules/ecs"
  app_name = var.app_name
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  target_group_arn = module.alb.target_group_arn
  task_cpu = var.task_cpu
  task_memory = var.task_memory
  container_image = var.container_image
  container_port = var.container_port
  aws_region = var.aws_region
  alb_security_group_id = module.alb.alb_security_group_id
  desired_count = var.desired_count
  depends_on = [module.alb]
}

