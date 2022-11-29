module "aws" {
  source = "./module/aws"
  region = var.region
}

module "vpc" {
  source = "./module/vpc"
  vpc_cidr = var.vpc-cidr
  pub_snet_details = {
    snet-pb-1 = var.snet-pb-1,
    snet-pb-2 = var.snet-pb-2,
    snet-pb-3 = var.snet-pb-3,
  }
}

module "sg" {
  source = "./module/sg"
  sg_details = var.sg_details

}

module "ec2" {
  source = "./module/ec2"
  ec2_sub = {
    ec2-001 = var.ec2-001,
    ec2-002 = var.ec2-002,
    ec2-003 = var.ec2-003,
  }
  sg = [lookup(module.sg.sg_id,"ec2-sg",null)]
  ami_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
}

