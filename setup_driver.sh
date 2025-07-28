#!/bin/bash

# VARIABLES CHANGED AS NEEDED
CUDA_VERSION="12.8"
BASHRC="$HOME/.bashrc"
CUDA_PATH="/usr/local/cuda-${CUDA_VERSION%.*}"

# CUDA INSTALLATION
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-ubuntu2404.pin
sudo mv cuda-ubuntu2404.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda-repo-ubuntu2404-12-8-local_12.8.1-570.124.06-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2404-12-8-local_12.8.1-570.124.06-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2404-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-8

## DRIVER INSTALLATION
sudo apt-get install -y nvidia-open
sudo apt-get install -y cuda-drivers

## ADD NVCC
if ! grep -q "${CUDA_PATH}" "$BASHRC"; then
    echo "Adding CUDA to .bashrc..."
    echo "export PATH=${CUDA_PATH}/bin:\$PATH" >> "$BASHRC"
    echo "export LD_LIBRARY_PATH=${CUDA_PATH}/lib64:\$LD_LIBRARY_PATH" >> "$BASHRC"
else
    echo "CUDA environment variables already exist in .bashrc"
fi



