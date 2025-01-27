#!/bin/bash

set -e  # Exit immediately if a command fails

# Install dependencies
sudo apt update && sudo apt upgrade
sudo apt install -y cmake unzip gettext curl git

# Create software directory if it doesn't exist
SOFTWARE_DIR=~/software
mkdir -p "$SOFTWARE_DIR"

# Install NVM (Node Version Manager)
NODE_DIR=$SOFTWARE_DIR/node
mkdir -p $NODE_DIR
cd $NODE_DIR

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

# Check if tree-sitter is installed
if ! command -v tree-sitter &> /dev/null; then
    echo "tree-sitter is not installed. Installing via NVM..."
    # Install Node.js LTS version using NVM
    nvm install -g tree-sitter-cli
else
    echo "tree-sitter is already installed. Version: $(tree-sitter --version)"
fi

# Verify tree-sitter installation
if ! command -v tree-sitter &> /dev/null; then
    echo "Error: tree-sitter still not found after installation!"
    exit 1
else
    echo "tree-sitter is installed. Version: $(tree-sitter --version)"
fi

# Install Neovim
NEOVIM_DIR="$SOFTWARE_DIR/neovim"


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

echo "installing rip grep"

RIP_GREP_DIR=$SOFTWARE_DIR/rip_grep
mkdir -p $RIP_GREP_DIR 
cd $RIP_GREP_DIR

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
sudo dpkg -i ripgrep_14.1.0-1_amd64.deb
