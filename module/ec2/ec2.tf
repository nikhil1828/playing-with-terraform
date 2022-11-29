resource "aws_instance" "web" {
  for_each        = var.ec2_sub
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = var.sg
  subnet_id       = each.value["pub-snet"]
#   count=length(var.ec2-tags)
  user_data = <<-EOF
  #!/bin/bash
  hostnamectl set-hostname ${each.value["hostname"]}
  apt update
  apt install nginx -y
  apt install docker.io -y
  EOF
#   user_data_base64 = "IyEvYmluL2Jhc2gKYXB0IHVwZGF0ZQphcHQgaW5zdGFsbCBuZ2lueCAteQphcHQgaW5zdGFsbCBkb2NrZXIuaW8gLXkKaG9zdG5hbWVjdGwgc2V0LWhvc3RuYW1lIG5naW54LXNlcnZlcg=="
  tags = {
    Name = "${terraform.workspace}-ec2-${each.value["hostname"]}"
  }
}
