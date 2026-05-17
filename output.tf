output "ec2_public_ip" {
  value = aws_instance.cloudops.public_ip
}

output "ssh_command" {
  value = "ssh -i /root/terraform-project/devops-key ec2-user@${aws_instance.cloudops.public_ip}"
}

output "nginx_url" {
  value = "https://${aws_instance.cloudops.public_ip}"
}
