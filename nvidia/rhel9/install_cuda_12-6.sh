#!/usr/bin/env sh

echo "--------------------------------------------------"
echo "Downloading the runfile"
echo "--------------------------------------------------"

# wget https://developer.download.nvidia.com/compute/cuda/12.6.0/local_installers/cuda_12.6.0_560.28.03_linux.run || exit 1

echo "--------------------------------------------------"
echo "The runfile has been downloaded and will be started."
echo "There will be a message telling you that you should abort if an nvidia driver is already installed."
echo "Ignore this message and continue."
echo "BUT REMEMBER TO UNCHECK THE NVIDIA DRIVER THAT IS DEFAULTED IN THIS RUNFILE."
echo "Also note that the install hangs at first but this is normal."
printf "Confirm that you are aware that you need to uncheck the driver. Type confirm: "
read -r response
echo "--------------------------------------------------"

if [ "$response" == "confirm" ]; then
    sudo sh cuda_12.6.0_560.28.03_linux.run
fi
