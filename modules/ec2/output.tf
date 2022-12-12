output "ec2-details" {
    value = {for k, v in aws_instance.web:k=>v.public_ip}
}