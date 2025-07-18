#!/bin/bash

# Update and install dependencies
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo yum install -y git curl

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add ec2-user to docker group so you can run without sudo
sudo usermod -aG docker ec2-user

# Install Docker Compose v2 (plugin-based)
DOCKER_CONFIG=/usr/local/lib/docker/cli-plugins
sudo mkdir -p $DOCKER_CONFIG
sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
  -o $DOCKER_CONFIG/docker-compose
sudo chmod +x $DOCKER_CONFIG/docker-compose

# Verify installations (optional logging)
docker --version
docker compose version

# Ensure correct permissions
chown -R ec2-user:ec2-user /home/ec2-user/app
