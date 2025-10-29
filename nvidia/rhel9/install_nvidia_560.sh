#!/usr/bin/env bash

arch=$(uname -m)
distro="rhel9"

sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-$distro.repo || exit 1
sudo dnf clean expire-cachep || exit 1
sudo dnf module install -y nvidia-driver:560-dkms || exit 1

echo "The installation was complete. Restart now."
