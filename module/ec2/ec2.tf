resource "aws_instance" "web" {
  for_each        = var.ec2_sub
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = var.sg
  subnet_id       = each.value["pub-snet"]
  user_data = <<-EOF
  #!/bin/bash
  hostnamectl set-hostname ${each.value["hostname"]}
  apt update
  sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
  systemctl restart sshd.service
  echo -e "12345\n12345"|passwd ubuntu
  apt install nginx -y
  apt install docker.io -y
  usermod -a -G docker ubuntu
  EOF
  tags = {
    Name = "${terraform.workspace}-ec2-${each.value["hostname"]}"
  }
}

