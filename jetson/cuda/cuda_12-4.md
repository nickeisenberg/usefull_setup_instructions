ask chatgpt for assistance

remove the existing cuda

```bash
sudo apt-get purge cuda-*
sudo apt-get autoremove --purge
```

see if anything is left
```
dpkg -l | grep cuda
```

remove what is not `nvidia-l4t-cuda` which is the tegra. This is needed.

run the following to install cuda12.4

```bash
# Please ensure your device is configured per the CUDA Tegra Setup Documentation.
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/arm64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.4.0/local_installers/cuda-tegra-repo-ubuntu2204-12-4-local_12.4.0-1_arm64.deb
sudo dpkg -i cuda-tegra-repo-ubuntu2204-12-4-local_12.4.0-1_arm64.deb
sudo cp /var/cuda-tegra-repo-ubuntu2204-12-4-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-4 cuda-compat-12-4
```

make sure to add the following to the bottom of your bashrc
```bash
export PATH=/usr/local/cuda-12/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12/lib64:$LD_LIBRARY_PATH
```

after this `nvcc --version` should work.
