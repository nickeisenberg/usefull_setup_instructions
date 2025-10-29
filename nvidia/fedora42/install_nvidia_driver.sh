#!/usr/bin/env bash

arch=$(uname -m)
distro="fedora42"
sudo dnf config-manager addrepo \
	--from-repofile=https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-$distro.repo || exit 1
sudo dnf clean expire-cache || exit 1

sudo dnf install nvidia-open

sudo dnf install -y kernel-devel-$(uname -r) kernel-headers-$(uname -r)

sudo dkms autoinstall

lspci -nnk | grep -A3 -E "VGA|Display"

### We created /etc/modprobe.d/blacklist-nouveau.conf
# these are the lines of /etc/modprobe.d/blacklist-nouveau.conf
blacklist nouveau
options nouveau modeset=0
###

sudo dracut --force

sudo reboot
