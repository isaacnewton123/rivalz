#!/bin/bash

# Script by Node Farmer
# Medium: https://medium.com/@cryptonodefarmer_80672
# X: https://x.com/_node_farmer_
# Telegram: https://t.me/+Hrs33jHFE0liMWNk
# Discord: https://discord.gg/8wDZrapvQG


# Define user and password variables for remote desktop
# Don't use root
USER="yourusername"
PASSWORD="yourpassword"

# Updates the package list
sudo apt update

# Installs GNOME Desktop
sudo apt install -y ubuntu-desktop

# Installs the remote desktop server (xrdp)
sudo apt install -y xrdp

# Adds the user USER with the password
sudo useradd -m -s /bin/bash $USER
echo "$USER:$PASSWORD" | sudo chpasswd

# Adds the user USER to the sudo group for administrative rights
sudo usermod -aG sudo $USER

# Configures xrdp to use the GNOME desktop
echo "gnome-session" > ~/.xsession

# Restarts the xrdp service
sudo systemctl restart xrdp

# Enables xrdp at startup
sudo systemctl enable xrdp

# Installs the necessary dependencies for Rivalz.ai rClient
sudo apt install -y wget

# Downloads the Rivalz.ai rClient AppImage
wget https://api.rivalz.ai/fragmentz/clients/rClient-latest.AppImage -O rClient-latest.AppImage

# Makes the AppImage executable
chmod +x rClient-latest.AppImage

# Creates the Documents directory if it doesn't exist
sudo -u $USER mkdir -p /home/$USER/Documents

# Moves the AppImage to the user's Documents directory
sudo mv rClient-latest.AppImage /home/$USER/Documents/rClient-latest.AppImage

# Changes the owner of the rClient to the specified user
sudo chown $USER:$USER /home/$USER/Documents/rClient-latest.AppImage

echo "Installation complete. GNOME Desktop, xrdp, and Rivalz.ai rClient have been installed. You can now connect via Remote Desktop with the user $USER."
