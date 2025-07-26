#!/bin/bash

# VARIABLES CHANGED AS NEEDED
CUDA_VERSION="12.8"
BASHRC="$HOME/.bashrc"
CUDA_PATH="/usr/local/cuda-${CUDA_VERSION%.*}"
EMAIL_ID="email.com"
SSH_CONFIG_FILE="$HOME/.ssh/config"

## CUDA INSTALLATION
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

## SETUP SSH FOR GITHUB
sudo apt-get install -y git

ssh-keygen -t ed25519 -C "${EMAIL_ID}" -f ~/.ssh/id_ed25519_work
ssh-add ~/.ssh/id_ed25519_work   # work

# Check if the .ssh/config file exists, if not create it
if [ ! -f "$SSH_CONFIG_FILE" ]; then
  echo "Creating $SSH_CONFIG_FILE..."
  touch "$SSH_CONFIG_FILE"
fi

if ! grep -q "github-work" "$SSH_CONFIG_FILE"; then
  echo -e "\n# Work GitHub" >> "$SSH_CONFIG_FILE"
  echo -e "Host github-work" >> "$SSH_CONFIG_FILE"
  echo -e "    HostName github.com" >> "$SSH_CONFIG_FILE"
  echo -e "    User git" >> "$SSH_CONFIG_FILE"
  echo -e "    IdentityFile ~/.ssh/id_ed25519_work" >> "$SSH_CONFIG_FILE"
  echo "Added Work GitHub configuration."
else
  echo "Work GitHub configuration already exists."
fi

echo "SSH config updated successfully!"

cat ~/.ssh/id_ed25519_work.pub

