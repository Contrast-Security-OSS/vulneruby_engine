#!/bin/bash
set -ex
apt update
apt upgrade
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb