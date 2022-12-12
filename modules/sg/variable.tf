variable "vpc_id" {
  description = "VPC in which SG has to to attached"
}
variable "sg_details" {
  description = "Desired Security Group rules"
  type = map(object({
    name        = string
    description = string
    ingress_rules = list(object({
      from_port         = number
      to_port           = number
      protocol          = string
      cidr_blocks       = list(string)
    }))
  }))
}

variable "environment" {
  type = string
}

variable "stage" {
  type = string
}