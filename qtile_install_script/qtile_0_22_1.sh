#!/bin/bash

# Install core dependencies
sudo apt-get install -y python3-cffi libpangocairo-1.0-0 --reinstall

# Install xcffib with pip
# This must be installed before cairocffi
pip3 install xcffib==1.3

# Install cairocffi with pip
pip3 install --no-cache-dir --no-build-isolation cairocffi==1.4.0

# Install Qtile
pip3 install qtile==0.22.1 --no-dependencies

# Create a desktop entry for Qtile. This is necessary however I am commenting it
# out since I already did this.
# echo "[Desktop Entry]
# Name=Qtile
# Comment=Qtile Session
# Exec=qtile start
# Type=Application
# Keywords=wm;tiling" | sudo tee /usr/share/xsessions/qtile.desktop
# 
# echo "Qtile installation completed successfully. You can select Qtile from your ses"
