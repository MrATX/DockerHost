#!/bin/bash

# reset-docker.sh
# Removes Docker and related packages to reset VM to a clean state

set -e

echo "Stopping Docker service (if running)..."
sudo systemctl stop docker || true
sudo systemctl disable docker || true

echo "Uninstalling Docker packages..."
sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Removing Docker GPG key and source list..."
sudo rm -f /etc/apt/sources.list.d/docker.list
sudo rm -f /usr/share/keyrings/docker-archive-keyring.gpg

echo "Removing Docker data directories..."
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm -rf ~/docker
sudo rm -rf ~/.docker

echo "Removing Docker group if exists..."
sudo groupdel docker || true

echo "Cleaning up unused packages..."
sudo apt autoremove -y
sudo apt clean

echo "Docker has been fully removed from the system."
