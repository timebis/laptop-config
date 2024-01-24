#!/bin/bash

# Path to your repository
REPO_DIR="$HOME/git/laptop-config"

# Backup directory within the repository
BACKUP_DIR="$REPO_DIR/backup"

# Current date and time for backup naming
CURRENT_DATETIME=$(date +"%Y%m%d-%H%M%S")

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to log a message
log_message() {
    echo -e "${GREEN}$(date): $1${NC}"
}

# Function to log an error message
log_error() {
    echo -e "${RED}$(date): $1${NC}"
}

# Ensure backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Backup current configuration files
log_message "Backing up current configuration files..."
cp -v ~/.bashrc "$BACKUP_DIR/.bashrc_$CURRENT_DATETIME"
cp -v ~/.bash_aliases "$BACKUP_DIR/.bash_aliases_$CURRENT_DATETIME"
cp -v ~/.config/Code/User/settings.json "$BACKUP_DIR/settings_$CURRENT_DATETIME.json"
cp -v ~/.config/Code/User/keybindings.json "$BACKUP_DIR/keybindings_$CURRENT_DATETIME.json"

# Copy Bash configuration files to the home directory
log_message "Updating Bash configuration..."
cp -v files/bash/.* ~/

# Set appropriate permissions for bash files
chmod 644 ~/.bashrc
chmod 644 ~/.bash_aliases

# Copy VS Code configuration files
log_message "Updating VS Code configuration..."
cp -v files/vs-code/* ~/.config/Code/User/

# Source the updated bash configuration files
log_message "Sourcing updated Bash configuration..."
source ~/.bashrc

log_message "Configuration update completed successfully."
