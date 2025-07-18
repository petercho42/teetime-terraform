output "ec2_public_ip" {
  value = aws_instance.django_ec2.public_ip
}
