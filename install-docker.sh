#!/bin/bash

# setup-docker.sh
# Installs Docker CE on Ubuntu (18.04+, 20.04+, 22.04+)

set -e

echo "Updating package list..."
sudo apt update

echo "Installing dependencies..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release

echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating package list (again)..."
sudo apt update

echo "Installing Docker CE..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Adding $USER to the docker group..."
sudo usermod -aG docker $USER

echo "Docker installation complete!"
echo "Log out and log back in for group changes to take effect."
echo "Then test Docker with: docker run hello-world"
