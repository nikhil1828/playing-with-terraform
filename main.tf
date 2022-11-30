terraform {
  backend "s3" {
    bucket = "site01-buket"
    key    = "terraform/backend/terraform.tfstate"
    region = "us-east-1"
  }
}

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

module "ec2" {
  source = "./module/ec2"
  ec2_sub = {
    ec2-001 = {
        pub-snet = lookup(module.vpc.pub_snetid,"snet-pb-1", null).id
        hostname = "server-1"
    },
    ec2-002 = {
        pub-snet = lookup(module.vpc.pub_snetid,"snet-pb-2", null).id
        hostname = "server-2"
    }
  }
  sg = [lookup(module.sg.sg_id,"ec2-sg",null)]
  ami_id = var.ami_id
  instance_type = var.instance_type
}

output "ec2-details" { value = module.ec2.ec2-details}
