module "vpc" {
  source           = "../modules/vpc"
  vpc_cidr         = var.vpc-cidr
  pub_snet_details = var.pub_snet_details
}