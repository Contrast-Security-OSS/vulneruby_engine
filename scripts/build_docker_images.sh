#!/usr/bin/env bash

source "scripts/config.sh"
source "scripts/colors.sh"
source "scripts/install_dependencies.sh"

ALPINE='alpine'

# Make sure docker/Dockerfile_base ARG RUBY_VER=X.X is equal to the smallest supported ruby version
# and ARG DISTRO='' is assingned to empty string.
build_docker_images(){
  echo -e "$BLUE[Docker] Building images...$WHITE"

  length=${#VULNERUBY_RUBIES[@]}

  # Go through all RUBY versions:
  for (( i=0; i<${length}; i++ )); do
    # Get current run ruby version: Current and Next in line
    current_version=${VULNERUBY_RUBIES[$i]}
    # Version 3.0 is displayed as 3 This fixes this.
    current_version=$(fix_assign_three_zero_current i)
    next_version=${VULNERUBY_RUBIES[$i+1]}

    # On first run we must set ruby version from empty to current:
    if (($i == 0)); then
      echo "Initial run"
      initial_ruby_version
    fi

    # Prepare Dockerfile_base for next version:
    echo
    echo -e  "Building ruby version:" "$GREEN$current_version$WHITE"

    # Build base images:
    # e.g. 3.0
    build_image $current_version

    # Build linux based distros:
    # e.g. -slim-buster -alpineX.XX
    # For each version all of the available distros will be build.
    build_distro $current_version

    # Update ruby version to the next, or set to default on last run.
    set_ruby_version
  done
}

# After build the images can be pushed:
push_docker_images() {
  echo -e "$BLUE[Docker] Pushing images to Github...$WHITE"
  
  length=${#VULNERUBY_RUBIES[@]}
  for (( i=0; i<${length}; i++ )); do
    current_version=${VULNERUBY_RUBIES[$i]}
    # Version 3.0 is displayed as 3 This fixes this.
    current_version=$(fix_assign_three_zero_current i)

    # Push base tag images:
     push_image $current_version

    dist_length=${#VULNERUBY_DISTROS[@]}
    for (( j=0; j<${length}; j++ )); do
     current_distro=${VULNERUBY_DISTROS[$j]}
     # Push base + distro tags images:
     push_image $current_version $current_distro
     done
  done
  docker push  ghcr.io/contrast-security-oss/vulneruby_engine/base:2.7
}

# Builders:

# Build single image.
# e.g. docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:3.0-slim-bullseye -f ./docker/Dockerfile_base
# $1 ruby version as parameter.
# $2 distro
build_image() {
  if [ -z $2 ]; then
    ver=$1
    cmd=""$TARGET":"$ver" -f "$PATH_DOCKERFILE_BASE""
  else
    ver=$1
    dist=$2
    cmd=""$TARGET":"$ver""${dist//\"}" -f "$PATH_DOCKERFILE_BASE""
  fi
  docker image build . -t $cmd
}

# Push single image.
# $1 ruby version as parameter.
# $2 distro
push_image(){
  if [ -z $2 ]; then
    ver=$1
    cmd=""$TARGET":"$ver""
    docker image push $cmd
  else
    ver=$1
    dist=$2
    cmd=""$TARGET":"$ver""${dist//\"}""
    docker image push $cmd
  fi
}

# This will build each distro for te current ruby version.
# $1 => $current_version --> Current ruby version as param.
build_distro() {
  length=${#VULNERUBY_DISTROS[@]}
  # Go through All Distros:
  for (( j=0; j<${length}; j++ )); do
    # Set distro and install dependencies and run subset of images for
    current_distro=${VULNERUBY_DISTROS[$j]}
    next_distro=${VULNERUBY_DISTROS[$j+1]}

    echo
    echo -e  "with distro:" "$GREEN$current_distro$WHITE"

    set_distro $current_distro

    # Alpine Distro needs more work and changing of the whole Dockerfile_base.
    # [NOTE] If any changes are made to the file they need to be reflected here as well.
    if [[ "$current_distro" == *"$ALPINE"* ]]; then
      echo -e "Dockerfile_base in use. Writting..."
      # Add new packages inside this method: 
      install_alpine_dependecies
      # Build docker image:
      build_image $1 $current_distro
      # Restore file to default
      restore_to_default
      else
      # Build docker image:
      build_image $1 $current_distro
    fi

    # Reset after each run:
    reset_distro
  done
}

# Setters:

# Sets ARG RUBY_VER=X.X in Dockerfile_base
# After the first build we can start setting the next versions:
# But after the last we need to reset the state to '' for ruby
# version.
set_ruby_version() {
 if [ -z $next_version ]; then
    reset_ruby_version
    else
    sed -i '' "s/ARG RUBY_VER=$current_version/ARG RUBY_VER=$next_version/g" $PATH_DOCKERFILE_BASE
  fi
}
  
# On initial run set to required version. You may want to build only for a perticular version:
initial_ruby_version() {
  sed -i '' "s/ARG RUBY_VER=''/ARG RUBY_VER=$current_version/g" $PATH_DOCKERFILE_BASE
}

# On last run we need to reset to empty state:
reset_ruby_version() {
  sed -i '' "s/ARG RUBY_VER=$current_version/ARG RUBY_VER=''/g" $PATH_DOCKERFILE_BASE
}

# Sets ARGS DISTR=current distro
set_distro(){
  sed -i '' "s/ARG DISTRO=''/ARG DISTRO=$current_distro/g" $PATH_DOCKERFILE_BASE
}

# Sets ARGS DISTR=''
# Invoke on distro last iteration.
reset_distro(){
  sed -i '' "s/ARG DISTRO=$current_distro/ARG DISTRO=''/g" $PATH_DOCKERFILE_BASE
}

# Utils:

# Version 3.0 is displayed as 3 This fixes this.
# TODO: add one for 4.0 version.
#
fix_assign_three_zero_current() {
  if [ "`echo "${current_version} == 3.0" | bc`" -eq 1 ]; then
    echo 3.0;
    else 
    echo ${VULNERUBY_RUBIES[$1]}
  fi
}
