//decleration of vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.environment}-${var.stage}-vpc" 
  }
}

//decleration of public subnet
resource "aws_subnet" "pub-snet" {
  for_each = var.pub_snet_details
  vpc_id     = aws_vpc.vpc.id 
  cidr_block = each.value["cidr_block"]
  availability_zone = each.value["availability_zone"]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-${var.stage}-pub-snet-${each.value["availability_zone"]}" 
  }
}

# creating igw for pub snet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
  Name = "${var.environment}-${var.stage}-igw" 
  }
}

# creating a igw route table
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id

    route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
   }

   tags = {
   Name = "${var.environment}-${var.stage}-vpc-pub-rt"
   }
}

resource "aws_route_table_association" "pbsnet_assoc" {
 for_each = aws_subnet.pub-snet
 subnet_id   = each.value.id
 route_table_id = aws_route_table.pub_rt.id
}