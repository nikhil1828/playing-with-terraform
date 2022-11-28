# Decalring VPC CIDR
variable "vpc_cidr" {}

variable "pub_snet_details" {
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}