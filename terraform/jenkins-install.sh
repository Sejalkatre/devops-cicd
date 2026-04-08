#!/bin/bash
# Update system
apt-get update -y
apt-get upgrade -y

# Install Java (required for Jenkins)
apt-get install -y openjdk-11-jdk

# Add Jenkins repository
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'

# Install Jenkins
apt-get update -y
apt-get install -y jenkins

# Enable and start Jenkins service
systemctl enable jenkins
systemctl start jenkins

# Install Docker and Git
apt-get install -y docker.io git

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Add Jenkins user to Docker group
usermod -aG docker jenkins
