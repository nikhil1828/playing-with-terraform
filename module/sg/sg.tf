resource "aws_security_group" "allow_tls" {
  vpc_id      = var.vpc_id
  for_each    = var.sg_details
  name        = each.value["name"]
  description = each.value["description"]

  dynamic "ingress" {
    for_each = lookup(each.value, "ingress_rules", [])
    content {
      from_port         = lookup(ingress.value, "from_port", null)
      to_port           = lookup(ingress.value, "to_port", null)
      protocol          = lookup(ingress.value, "protocol", null)
      cidr_blocks       = lookup(ingress.value, "cidr_blocks", null)
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${terraform.workspace}-sg"
  }
}