#!/bin/bash

# Define the ZIP file and destination folder
ZIP_FILE="debs.zip"
DEST_FOLDER="./"

wget -c https://github.com/minthawzin/ubuntu_setup/releases/download/v0.0.1/debs.zip
# Create the destination folder if it doesn't exist
mkdir -p "$DEST_FOLDER"

# Extract the ZIP file
unzip "$ZIP_FILE" -d "$DEST_FOLDER"

sudo dpkg -i debs/anydesk_7.0.1-1_amd64.deb
sudo dpkg -i debs/code_1.102.2-1753187809_amd64.deb
sudo dpkg -i debs/slack-desktop-4.45.64-amd64.deb
sudo dpkg -i debs/google-chrome-stable_current_amd64.deb

sudo apt-get --fix-broken install