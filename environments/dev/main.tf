# test oidc


variable "org" { type = string }
variable "env" { type = string }
variable "app" { type = string }
variable "region" { type = string }

module "vpc" {
  source = "../../modules/vpc"

  org    = var.org
  env    = var.env
  app    = var.app
  region = var.region

  vpc_cidr = "10.10.0.0/16"
  azs      = ["eu-west-2a", "eu-west-2b"]

  public_subnet_cidrs  = ["10.10.0.0/24", "10.10.1.0/24"]
  private_subnet_cidrs = ["10.10.10.0/24", "10.10.11.0/24"]

  tags = {
    Owner = "your-name"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
