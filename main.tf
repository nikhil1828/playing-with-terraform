terraform {
  cloud {
    organization = "nikhil-org-001"

    workspaces {
      name = "api-driven-workspace-cicd"
    }
  }
}

provider "aws" {
  region  = "ap-southeast-1"
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
    }
  }
  sg = [lookup(module.sg.sg_id,"ec2-sg",null)]
  ami_id = var.ami_id
  instance_type = var.instance_type
}

output "EC2-IP" { 
  value = module.ec2.ec2-details
}
