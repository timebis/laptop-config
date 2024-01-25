#!/bin/bash

# Get the path of the current Git repository
REPO_DIR=$(git rev-parse --show-toplevel)
# Check if the current directory is a Git repository
if [ -z "$REPO_DIR" ]; then
    echo "Error: Current directory is not a Git repository."
    exit 1
fi

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
# Backup current configuration files
log_message "Backing up current configuration files..."
cp -v ~/.bashrc "$BACKUP_DIR/.bashrc_$CURRENT_DATETIME"
if [ $? -ne 0 ]; then
    log_error "Backup of .bashrc failed"
    exit 1
fi
cp -v ~/.bash_aliases "$BACKUP_DIR/.bash_aliases_$CURRENT_DATETIME"
if [ $? -ne 0 ]; then
    log_error "Backup of .bash_aliases failed"
    exit 1
fi
cp -v ~/.config/Code/User/settings.json "$BACKUP_DIR/settings_$CURRENT_DATETIME.json"
if [ $? -ne 0 ]; then
    log_error "Backup of settings.json failed"
    exit 1
fi
cp -v ~/.config/Code/User/keybindings.json "$BACKUP_DIR/keybindings_$CURRENT_DATETIME.json"
if [ $? -ne 0 ]; then
    log_error "Backup of keybindings.json failed"
    exit 1
fi

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
