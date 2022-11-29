variable "region" {
  default = "ap-southeast-1"
}

variable "vpc-cidr" {
  type = string
}

variable "snet-pb-1" {
  type = object ({ cidr_block = string
  availability_zone = string
  })
}

variable "snet-pb-2" {
  type = object({
    cidr_block = string
    availability_zone = string
  })
}

variable "snet-pb-3" {
  type = object({
    cidr_block = string
    availability_zone = string
  })
}

variable "sg_details" {
  type = map(object({
    name        = string
    description = string
    # vpc_id      = string
    ingress_rules = list(object({
      from_port         = number
      to_port           = number
      protocol          = string
      cidr_blocks       = list(string)
    }))
  }))
}

variable "ec2-001" {
  type = object({
    pub-snet = string
    hostname = string
  })
}

variable "ec2-002" {
  type = object({
    pub-snet = string
    hostname = string
  })
}

variable "ec2-003" {
  type = object({
    pub-snet = string
    hostname = string
  })
}

variable "ami_id" {
  validation {
    # condition = length(var.ami_id) == 21 && substr(var.ami_id, 0, 4) == "ami-"
    condition = can(regex("([a]?[m]?[i-]*[a-z]*[0-9])",var.ami_id))
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}