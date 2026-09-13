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
