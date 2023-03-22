#!/usr/bin/env bash

source "scripts/colors.sh"
source "scripts/validate.sh"
source "scripts/build_docker_images.sh"

echo -e "$BLUE[Docker]$WHITE ENV variables:"

# Validation of ENV variables:
validate_pat
validate_gh_user

echo

# Loggin to Docker:
if [ $PAT_VALID == true ] && [ $GH_USERNAME_VALID == true ]; then
  echo -e "$BLUE[Docker] Logging in...$WHITE"
 # echo $CR_PAT | docker login ghcr.io -u $GH_USERNAME --password-stdin
  echo

  # Build images from config:
  build_docker_images

  # Push the images
  # Comment this out for local debug and troubleshooting, first test run.
  # push_docker_images
fi
