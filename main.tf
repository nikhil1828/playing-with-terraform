provider "aws" {
  region  = "ap-southeast-1"
}

module "vpc" {
  source = "./module/vpc"
  vpc_cidr = "10.0.0.0/20"
  pub_snet_details = {
    "snet-pb-1" ={
      cidr_block = "10.0.0.0/21"
      availability_zone = "ap-southeast-1a"
    },
    "snet-pb-2" ={
      cidr_block = "10.0.8.0/22"
      availability_zone = "ap-southeast-1b"
    },
    "snet-pb-3" ={
      cidr_block = "10.0.12.0/22"
      availability_zone = "ap-southeast-1c"
    }
  }
}

module "sg" {
  source = "./module/sg"
  sg_details = {
    "ec2-sg" = {
        name        = "ec2-sg"
        description = "SG for ec2"
        vpc_id      = module.vpc.vpc_id
        ingress_rules = [
        {
            from_port         = 22
            to_port           = 22
            protocol          = "tcp"
            cidr_blocks       = ["0.0.0.0/0"]
        },
        {
            from_port         = 80
            to_port           = 80
            protocol          = "tcp"
            cidr_blocks       = ["0.0.0.0/0"]
        }
        ]
    }
  }
}

module "ec2" {
  source = "./module/ec2"
  ec2_sub = {
    ec2-001 = {
      pub-snet = lookup(module.vpc.pub_snetid,"snet-pb-1", null).id
    },
    ec2-002 = {
      pub-snet = lookup(module.vpc.pub_snetid,"snet-pb-2", null).id
    },
    ec2-003 = {
      pub-snet = lookup(module.vpc.pub_snetid,"snet-pb-3", null).id
    }
  }
  sg = [lookup(module.sg.sg_id,"ec2-sg",null)]
  ami_id = "ami-00e912d13fbb4f225"
  instance_type = "t2.micro"
  key_name = "singapore"
}