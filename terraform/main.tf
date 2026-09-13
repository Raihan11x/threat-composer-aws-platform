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
