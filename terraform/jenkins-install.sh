#!/bin/bash
# Update system
apt-get update -y
apt-get upgrade -y

# Install Java (required for Jenkins)
apt-get install -y openjdk-11-jdk

# Add Jenkins repository key (new method for Ubuntu 24.04)
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository with signed-by option
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

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
