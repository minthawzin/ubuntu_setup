#!/bin/bash

sudo dpkg -i debs/anydesk_7.0.1-1_amd64.deb
sudo dpkg -i debs/code_1.102.2-1753187809_amd64.deb
sudo dpkg -i debs/slack-desktop-4.45.64-amd64.deb
sudo dpkg -i debs/google-chrome-stable_current_amd64.deb

sudo apt-get --fix-broken install