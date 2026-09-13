module "ecr" {
  source = "./modules/ecr"

  repository_name = "threat-composer"
}