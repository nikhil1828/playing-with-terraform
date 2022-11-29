vpc-cidr = "10.0.0.0/20"

snet-pb-1 ={
    cidr_block = "10.0.0.0/21",
    availability_zone = "ap-southeast-1a"
}

snet-pb-2 ={
    cidr_block = "10.0.8.0/22",
    availability_zone = "ap-southeast-1b"
}

snet-pb-3 ={
    cidr_block = "10.0.12.0/22",
    availability_zone = "ap-southeast-1c"
}

sg_details = {
    "ec2-sg" = {
        name        = "ec2-sg"
        description = "SG for ec2"
        # vpc_id      = module.vpc.vpc_id
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

ec2-001 = {
    pub-snet = lookup(module.vpc.pub_snetid,"snet-pb-1", null).id
    hostname = "server-1"
}

ec2-002 = {
    pub-snet = lookup(module.vpc.pub_snetid,"snet-pb-2", null).id
    hostname = "server-2"
}

ec2-003 = {
    pub-snet = lookup(module.vpc.pub_snetid,"snet-pb-3", null).id
    hostname = "server-3"
}

ami_id = "ami-00e912d13fbb4f225"

instance_type = "t2.micro"

key_name = "singapore"