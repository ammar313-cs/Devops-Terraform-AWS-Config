#!/bin/bash

# Update package lists
apt-get update

# Install Apache web server
apt-get install -y apache2

# Start Apache service
systemctl start apache2 

# enable Apache service
systemctl enable apache2 

# Check if Apache is listening on port 80
netstat -tulpn | grep :80

# If Apache is not listening on port 80, troubleshoot and restart
if [[ $(netstat -tulpn | grep :80) = "" ]]; then
  echo "Apache is not listening on port 80. Troubleshooting..."
  # troubleshooting, checking for errors in Apache logs if any
  service apache2 restart
fi
