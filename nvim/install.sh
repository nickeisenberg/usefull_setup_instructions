#!/bin/bash

MYPWD=$(pwd)

set -e  # Exit immediately if a command fails

# Install dependencies
sudo apt update && sudo apt upgrade
sudo apt install -y cmake unzip gettext curl git

# Create software directory if it doesn't exist
SOFTWARE_DIR="${HOME}/.local/src/nvim"
rm -rf "$SOFTWARE_DIR"
mkdir -p "$SOFTWARE_DIR"

git clone https://github.com/neovim/neovim.git "$SOFTWARE_DIR"

# Checkout the correct release branch
cd "$SOFTWARE_DIR"
git checkout release-0.10

# Build and install Neovim
make distclean
make -j CMAKE_BUILD_TYPE=Release
sudo make install

cd "${MYPWD}"
