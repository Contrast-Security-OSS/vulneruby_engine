#!/bin/bash
set -ex
apt-get -y update
apt-get -y upgrade
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt-get install ./google-chrome-stable_current_amd64.deb