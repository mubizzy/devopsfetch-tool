#!/bin/bash

# Install necessary dependencies
sudo apt-get update
sudo apt-get install -y net-tools docker.io nginx jq

# Copy devopsfetch.sh to /usr/local/bin
sudo cp devopsfetch.sh /usr/local/bin/devopsfetch
sudo chmod +x /usr/local/bin/devopsfetch

# Set up systemd service
/usr/local/bin/devopsfetch setup_systemd_service

echo "Installation complete. Use 'devopsfetch -h' for usage instructions."