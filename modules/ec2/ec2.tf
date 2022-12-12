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
  apt install net-tools -y
  usermod -a -G docker ubuntu
  echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzF1AiAsrF3Q6dx+66DOaFhYpaMLKMqf5Hard6wHpS5vRtNHk+F88BTN/adlU685VJbE9GwyXyL/qlb6X73yIQjhPvb1wtFQhRHre3brSiPEZc+ClWV7yvo/rs3pdrwzjCspMIIVnACt9oT7Wa6agBmX2z8wIKo4flF6ujk7EliGnt/mwiGU+Mqq6JBCQ0A05bVZnTv10NN1lXbUQ50NX7bsVejweticrlJQ08qqM//NfLSadt9v1ci2QAFUcCuQjExuDhlC1hn2hazG4iZ/B26IB4F99GrpT5LZZBEtHC63NucyWIIPThTEsQAru7C44xOii2jT+42xS2uMvG1LEoe3Tdpx1kgNNnG2BYSLNQ927Qv61Rm2RR7bu14nq3ZLPoI5bxYla08udvMCW25oM0YndaY0/FsxuQK8VcFjadYmQoouSpVVELc6XZq/KN0Ae0mT+0kPeL5RhGbJJq+I3AzdpIE5CR8tP1GxuJjSMC1vM+pheyE/VHgRLONgXSv4k= admin1@system1" >> /home/ubuntu/.ssh/authorized_keys"
  EOF
  tags = {
    Name = "${terraform.workspace}-ec2-${each.value["hostname"]}"
  }
}

