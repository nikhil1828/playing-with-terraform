variable "ami_id" {
    description = "Desired AMI's id for instances"
    type = string
    validation {
        # condition = length(var.ami_id) == 21 && substr(var.ami_id, 0, 4) == "ami-"
        condition = can(regex("([a]?[m]?[i-]*[a-z]*[0-9])",var.ami_id))
        error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
    }
}

variable "instance_type" {
    description = "Desired instance type"
    type = string
}

variable "sg" {}

variable "ec2_sub" {
    description = "Desired subnet's id for instance"
    type = map(object({
            pub-snet = string
            hostname = string
    }))
}

variable "environment" {
  type = string
}

variable "stage" {
  type = string
}