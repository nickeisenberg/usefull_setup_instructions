#!/bin/bash

set -e  # Exit immediately if a command fails

# Install dependencies
sudo apt update && sudo apt upgrade
sudo apt install -y cmake unzip gettext curl git

# Install NVM (Node Version Manager)
mkdir -p ~/software/node
cd ~/software/node

curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh -o install_nvm.sh
bash install_nvm.sh

# # Add NVM to bashrc for persistent use only if not already present
# echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
# echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
# echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc

export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

if ! command -v nvm &> /dev/null; then
    echo "nvm is not installed. "
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "npm is not installed. Installing Node.js via NVM..."
    # Install Node.js LTS version using NVM
    nvm install --lts
else
    echo "npm is already installed. Version: $(npm --version)"
fi

# Verify npm installation
if ! command -v npm &> /dev/null; then
    echo "Error: npm still not found after installation!"
    exit 1
else
    echo "npm is installed. Version: $(npm --version)"
fi

# Install Neovim
SOFTWARE_DIR=~/software
NEOVIM_DIR="$SOFTWARE_DIR/neovim"

# Create software directory if it doesn't exist
mkdir -p "$SOFTWARE_DIR"

# Clone or update Neovim repository
if [ ! -d "$NEOVIM_DIR" ]; then
    git clone https://github.com/neovim/neovim.git "$NEOVIM_DIR"
else
    cd "$NEOVIM_DIR"
    git fetch --all
    git pull
fi

# Checkout the correct release branch
cd "$NEOVIM_DIR"
git checkout release-0.10

# Build and install Neovim
make distclean
make CMAKE_BUILD_TYPE=Release
sudo make install

echo "Neovim installation completed successfully!"
