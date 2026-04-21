#!/bin/bash
set -e

echo "Updating system..."
sudo apt update -y

echo "Installing Apache..."
sudo apt install apache2 -y

echo "Starting Apache..."
sudo systemctl enable --now apache2

echo "Creating webpage..."
echo "<h1>Welcome to the Automated Web Server!</h1>" | sudo tee /var/www/html/index.html

echo "Done!"
