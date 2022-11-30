module "aws" {
  source = "./module/aws"
  region = var.region
}

module "vpc" {
  source = "./module/vpc"
  vpc_cidr = var.vpc-cidr
  pub_snet_details =  var.pub_snet_details
}

module "sg" {
  source = "./module/sg"
  vpc_id = module.vpc.vpc_id
  sg_details = var.sg_details
}

# module "ec2" {
#   source = "./module/ec2"
#   ec2_sub = var.ec2_sub
#   sg = [lookup(module.sg.sg_id,"ec2-sg",null)]
#   ami_id = var.ami_id
#   instance_type = var.instance_type
#   key_name = var.key_name
# }
