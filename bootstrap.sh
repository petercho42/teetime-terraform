#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user

# Install git & clone your project
yum install -y git
git clone https://github.com/yourusername/yourrepo.git /home/ec2-user/app

# Optional: build & run Docker
cd /home/ec2-user/app
docker build -t teetime-app .
docker run -d -p 80:8000 teetime-app
