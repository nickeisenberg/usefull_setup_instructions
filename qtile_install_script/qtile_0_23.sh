#!/bin/bash

# Install core dependencies
sudo apt-get install -y python3-cffi libpangocairo-1.0-0 --reinstall

pip install xcffib

# for the PulseVolume widget
pip install pulsectl-asyncio

pip install qtile

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

