module "ec2" {
  source = "../modules/ec2"
  ec2_sub = {
    ec2-001 = {
      pub-snet = lookup(module.vpc.pub_snetid, "snet-pb-1", null).id
      hostname = "server-1"
    }
  }
  sg            = [lookup(module.sg.sg_id, "ec2-sg", null)]
  ami_id        = var.ami_id
  instance_type = var.instance_type
  environment = var.environment
  stage = var.stage
}