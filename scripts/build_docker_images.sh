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

    # Prepare Dockerfile_base for next version:
    echo
    echo -e  "Building ruby version:" "$GREEN$current_version$WHITE"

    # On last run set to first version again to rebuild with different distro.
    if [ -z $next_version ]; then
      next_version=${VULNERUBY_RUBIES[0]}
      # Version 3.0 is displayed as 3 This fixes this.
      next_version=$(fix_assign_three_zero_next 0)
    fi

    # Build base images:
    # e.g. 3.0
    build_image $current_version

    # Build linux based distros:
    # e.g. -slim-buster -alpineX.XX
    # For each version all of the available distros will be build.
    build_distro $current_version

    # After the first build we can start setting the next versions:
    # We need to install all distros for current versions as well
    # before changing it:
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
    cmd=""$TARGET":"$current_version" -f "$PATH_DOCKERFILE_BASE""
    "`docker image build . -t "$TARGET":"$1" -f "$PATH_DOCKERFILE_BASE"`"
  else
    ver=$1
    dist=$2
    cmd=""$TARGET":"$ver""${dist//\"}" -f "$PATH_DOCKERFILE_BASE""
    # distro format must follow the '-' pattern (-alpine3.2)
    "`docker image build . -t $cmd`"
  fi
}

# Push single image.
# $1 ruby version as parameter.
# $2 distro
push_image(){
  if [ -z $2 ]; then
    ver=$1
    cmd=""$TARGET":"$ver""
    "`docker image push $cmd`"
  else
    ver=$1
    dist=$2
    cmd=""$TARGET":"$ver""${dist//\"}""
    "`docker image push $cmd`"
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
      echo "ALPINE"
      # Add new packages inside this method: 
      install_alpine_dependecies
    fi

    # Build docker image:
    build_image $1 $current_distro

    # Reset after each run:
    reset_distro
  done
}

# Setters:

# Sets ARG RUBY_VER=X.X in Dockerfile_base
set_ruby_version() {
  sed -i '' "s/ARG RUBY_VER=$current_version/ARG RUBY_VER=$next_version/g" $PATH_DOCKERFILE_BASE
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

# Version 3.0 is displayed as 3 This fixes this.
# TODO: add one for 4.0 version.
#
fix_assign_three_zero_next() {
  if [ "`echo "${next_version} == 3.0" | bc`" -eq 1 ]; then
    echo 3.0;
    else 
    echo ${VULNERUBY_RUBIES[$1]}
  fi
}
