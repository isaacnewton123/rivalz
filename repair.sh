#!/bin/bash

# Version 1.1

# Script by Node Farmer
# Medium: https://medium.com/@cryptonodefarmer_80672
# X: https://x.com/_node_farmer_
# Telegram: https://t.me/+Hrs33jHFE0liMWNk
# Discord: https://discord.gg/8wDZrapvQG


# Defines the service file path
SERVICE_FILE="/etc/systemd/system/default-interface-config.service"

# Checks if the script is being run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Installs ethtool if it is not already installed
if ! command -v ethtool &> /dev/null; then
  echo "ethtool not found, installing..."
  apt-get update
  apt-get install -y ethtool
fi

# Gets the default network interface
DEFAULT_INTERFACE=$(ip route show default | awk '/default/ {print $5}')

# Creates the systemd service file
cat <<EOL > $SERVICE_FILE
[Unit]
Description=Configure default network interface
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/ethtool -s $DEFAULT_INTERFACE speed 1000 duplex full autoneg off
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOL

# Reloads systemd to recognize the new service
systemctl daemon-reload

# Enables the service to start on boot
systemctl enable default-interface-config.service

# Starts the service immediately
systemctl start default-interface-config.service

echo "Service default-interface-config has been installed and started on interface $DEFAULT_INTERFACE."
