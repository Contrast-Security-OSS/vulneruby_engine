#!/bin/bash

set -eo pipefail

VERSION="99.0.4844.51"
ARCH="linux64"

CHROMEAPP=google-chrome
if ! type -a google-chrome > /dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install libappindicator3-1:amd64 libindicator3-7:amd64
fi

wget -c -nc --retry-connrefused --tries=0 https://chromedriver.storage.googleapis.com/${VERSION}/chromedriver_${ARCH}.zip
unzip -o -q chromedriver_${ARCH}.zip
mv chromedriver /usr/local/bin/chromedriver
rm chromedriver_${ARCH}.zip