module "sg" {
  source     = "../modules/sg"
  vpc_id     = module.vpc.vpc_id
  sg_details = var.sg_details
}