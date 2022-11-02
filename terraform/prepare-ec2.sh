#!/bin/bash -xe
sleep 30
sudo apt-get update
sudo apt-get -y install \
 ca-certificates \
 curl \
 gnupg \
 lsb-release
mkdir -p /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo apt-get update
sudo apt-get -y install docker.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install

sudo aws ecr get-login-password --region eu-central-1 | sudo docker login --username AWS --password-stdin 644435390668.dkr.ecr.eu-central-1.amazonaws.com
sudo docker pull 644435390668.dkr.ecr.eu-central-1.amazonaws.com/mateusz-kiszka-nginx:latest
sudo docker pull 644435390668.dkr.ecr.eu-central-1.amazonaws.com/mateusz-kiszka-ted-search:latest

sudo docker-compose up -d