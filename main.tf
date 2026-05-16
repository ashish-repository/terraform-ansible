# Get Latest Amazon Linux 2023 AMI

data "aws_ami" "amazon_linux_2023" {

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get Default VPC

data "aws_vpc" "default" {
  default = true
}

# Get Default Subnets

data "aws_subnets" "default" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Import Existing Public Key into AWS

resource "aws_key_pair" "devops_key" {

  key_name = "devops-key"

  public_key = file("/root/terraform-project/devops-key.pub")
}

# Security Group

resource "aws_security_group" "cloudops_sg" {

  name        = "cloudops-nginx-sg"
  description = "Allow SSH HTTP HTTPS"

  vpc_id = data.aws_vpc.default.id

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloudops-nginx-sg"
  }
}

# Create EC2 Instance

resource "aws_instance" "cloudops" {

  ami = data.aws_ami.amazon_linux_2023.id

  instance_type = "t3.micro"

  key_name = aws_key_pair.devops_key.key_name

  subnet_id = data.aws_subnets.default.ids[0]

  vpc_security_group_ids = [
    aws_security_group.cloudops_sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "cloudops-ec2"
  }
}
