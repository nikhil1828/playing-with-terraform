region = "ap-southeast-1"

vpc-cidr = "10.0.0.0/20"
pub_snet_details = {
  snet-pb-1 = {
    cidr_block        = "10.0.0.0/21",
    availability_zone = "ap-southeast-1a"
  }
}

sg_details = {
  "ec2-sg" = {
    name        = "ec2-sg"
    description = "SG for ec2"
    ingress_rules = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }]
  }
}

ami_id        = "ami-00e912d13fbb4f225"
instance_type = "t2.micro"
