module "ecr" {
  source = "./modules/ecr"

  repository_name = "threat-composer"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "network" {
  source = "./modules/network"

  name_prefix        = local.name_prefix
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
  common_tags = local.common_tags
}

module "route53_zone" {
  source = "./modules/route53-zone"

  domain_name = var.domain_name
  common_tags = local.common_tags
}

module "acm" {
  source = "./modules/acm"

  domain_name    = local.app_hostname
  hosted_zone_id = module.route53_zone.zone_id
  common_tags    = local.common_tags
}

module "iam" {
  source = "./modules/iam"

  name_prefix = local.name_prefix
  common_tags = local.common_tags
}

module "load_balancer" {
  source = "./modules/alb"

  name_prefix       = local.name_prefix
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  certificate_arn   = module.acm.certificate_arn
  app_port          = 8080
  health_check_path = "/"
  common_tags       = local.common_tags
}

module "ecs" {
  source = "./modules/ecs"

  name_prefix                     = local.name_prefix
  vpc_id                          = module.network.vpc_id
  subnet_ids                      = module.network.public_subnet_ids
  load_balancer_security_group_id = module.load_balancer.security_group_id
  target_group_arn                = module.load_balancer.target_group_arn
  image_uri                       = "${module.ecr.repository_url}:${var.image_tag}"
  execution_role_arn              = module.iam.execution_role_arn
  task_role_arn                   = module.iam.task_role_arn
  container_port                  = 8080
  desired_count                   = var.desired_count
  task_cpu                        = 256
  task_memory                     = 512
  log_retention_days              = 30
  assign_public_ip                = true
  cpu_architecture                = "ARM64"
  common_tags                     = local.common_tags

  depends_on = [module.load_balancer]
}
