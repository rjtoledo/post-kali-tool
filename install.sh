#!/bin/bash

# Title: Kali Linux Post-Installation Tool Setup
# Author: Rj Toledo
# Description: This script automates the installation of essential tools on Kali Linux.
# License: MIT License
# Usage: Run the script with root privileges. Example: sudo ./install-tools.sh

# Exit on any error
set -e

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to print messages in green (success)
function print_success() {
    echo -e "${GREEN}[✔] $1${NC}"
}

# Function to print messages in red (error)
function print_error() {
    echo -e "${RED}[✘] $1${NC}" >&2
    exit 1
}

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    print_error "Please run this script as root or with sudo."
fi

# Update and upgrade the system
echo "Updating and upgrading system packages..."
if apt update -y && apt upgrade -y; then
    print_success "System updated successfully."
else
    print_error "Failed to update the system."
fi

# Array of tools to install
tools=(
    "burpsuite"
    "seclists"
    "autorecon"
    "sliver"
    "ligolo-ng"
    "bloodhound"
    "peass"
    "nishang"
    "subfinder"
    "assetfinder"
    "nuclei"
    "finalrecon"
    "bettercap"
)

# Install each tool
for tool in "${tools[@]}"; do
    echo "Installing $tool..."
    if apt install -y "$tool"; then
        print_success "$tool installed successfully."
    else
        print_error "Failed to install $tool."
    fi
done

# Final system update after tool installation
echo "Performing final system update..."
if apt update -y && apt upgrade -y; then
    print_success "System updated after tool installation."
else
    print_error "Failed to perform the final update."
fi

echo -e "${GREEN}All tools installed successfully!${NC}"
