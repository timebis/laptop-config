#!/bin/bash

# Directory to check and file path
WG_DIR="/etc/wireguard"
WG_FILE="$WG_DIR/wg0.conf"

# Check if /etc/wireguard is accessible and empty
if ! sudo ls $WG_DIR &>/dev/null; then
    echo "Cannot access $WG_DIR. Please check permissions."
    exit 1
elif [ "$(sudo ls -A $WG_DIR)" ]; then
    echo "$WG_DIR is not empty. Exiting."
    exit 1
else
    echo "The $WG_DIR directory is empty. Proceeding with configuration."
fi

# Ensure .env variables are exported
set -a
source .env
set +a

# Use envsubst to substitute environment variables and write to wg0.conf
# Writing to /etc/wireguard and modifying file permissions requires root privileges
sudo envsubst < files/wireguard/wg0.conf.template | sudo tee $WG_FILE > /dev/null

# Set permissions to 600 for wg0.conf
sudo chmod 600 $WG_FILE

echo "WireGuard configuration has been updated and permissions set to 600."
