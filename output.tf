output "ec2_public_ips" {

  value = aws_instance.cloudops.public_ip
}

output "ssh_command" {

  value = "ssh -i /root/terraform-project/devops-key ec2-user@${aws_instance.cloudops.public_ip}"
}
