# Decalring VPC CIDR
variable "vpc_cidr" {
  description = "Desired CIDR of VPC"
  type = string
}

variable "pub_snet_details" {
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}

variable "environment" {
  type = string
}

variable "stage" {
  type = string
}