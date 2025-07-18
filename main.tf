provider "aws" {
  region = "us-east-1"
}

# Create a key pair using your local public key
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("/Users/petercho/.ssh/id_rsa.pub")
}

# Security Group to allow SSH and HTTP
resource "aws_security_group" "django_sg" {
  name        = "django-sg"
  description = "Allow SSH and HTTP"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "django_ec2" {
  ami           = "ami-0871b7e0b83ae16c4"  # Amazon Linux 2 (check region)
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.django_sg.name]

  user_data = file("bootstrap.sh")  # <-- this script installs Docker, pulls app

  tags = {
    Name = "DjangoEC2Instance"
  }
}
