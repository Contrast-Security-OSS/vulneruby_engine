#!/usr/bin/env bash

source "scripts/config.sh"
source "scripts/colors.sh"
# source "scripts/install_dependencies.sh"

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
    current_version=$(fix_assing_three_zero_current i)
    next_version=${VULNERUBY_RUBIES[$i+1]}

    # Prepare Dockerfile_base for next version:
    echo
    echo -e  "Building ruby version:" "$GREEN$current_version$WHITE"

    # On last run set to first version again to rebuild with different distro.
    if [ -z $next_version ]; then
      next_version=${VULNERUBY_RUBIES[0]}
      # Version 3.0 is displayed as 3 This fixes this.
      next_version=$(fix_assing_three_zero_next 0)
    fi

    # First run alway starts with lowest version no need to adjust.
    # It is special case. The current version is set here and in the file.
    # if [[ $i -gt 0 ]]; then
    #   echo $current_version
    #   echo $next_version
      
    # fi
 
    # Build base images:
    # e.g. 3.0
    build_image $current_version

    # Build linux based distros:
    # e.g. -slim-buster -alpineX.XX
    build_distro $current_version

    # After the first build we can start setting the next versions:
    # We need to install all distros for current versions as well
    # before changing it:
    set_ruby_version
  done
}

# Builders: 

# Build single image.
# $1 ruby version as parameter.
build_image() {
  "`docker image build . -t ghcr.io/contrast-security-oss/vulneruby_engine/base:$1 -f ./docker/Dockerfile_base`"
}

# This will build each distro for te current ruby version.
# $1 => $current_version --> Current ruby version as param.
build_distro() {
  length=${#VULNERUBY_DISTROS[@]}
  # Go through All Distros:
  for (( j=0; j<${length}; j++ )); do
    # Set distro and install dependencies and run subset of images for
    # Current ruby version and build again
    current_distro=${VULNERUBY_DISTROS[$j]}
    next_distro=${VULNERUBY_DISTROS[$j+1]}

    echo
    echo -e  "with distro:" "$GREEN$current_distro$WHITE"

    # On last run reset distro:
    # if not set it to the next one.
    if [ -z $next_distro ]; then
      reset_distro;
      else
        # First run alway starts with '' distro
        if [[ $j -gt 0 ]]; then
          set_initial_distro ;
          else
          set_distro $current_distro
        fi
    fi

    # Alpine Distro needs more work and changing of the whole Dockerfile_base.
    # [NOTE] If any changes are made to the file they need to be reflected here as well.
    if [[ "$current_distro" == *"$ALPINE"* ]]; then
      echo "Skipping Alpine for now...";
      else
      # Build docker image:
      build_image $1
    fi
  done
}

# Setters:

# Sets ARG RUBY_VER=X.X in Dockerfile_base
set_ruby_version() {
  echo sed: "s/ARG RUBY_VER=$current_version/ARG RUBY_VER=$next_version/g"
  sed -i '' "s/ARG RUBY_VER=$current_version/ARG RUBY_VER=$next_version/g" ./docker/Dockerfile_base
}

# First run alway starts with '' distro
set_initial_distro() {
  sed -i '' "s/ARG DISTRO=''/ARG DISTRO=$current_distro/g" ./docker/Dockerfile_base
}

# Sets ARGS DISTR=current distro
set_distro(){
  echo "s/ARG DISTRO=$current_distro/ARG DISTRO=$next_distro/g"
  sed -i '' "s/ARG DISTRO=$current_distro/ARG DISTRO=$next_distro/g" ./docker/Dockerfile_base
}

# Sets ARGS DISTR=''
# Invoke on distro last iteration.
reset_distro(){
  echo "s/ARG DISTRO=$current_distro/ARG DISTRO=''/g"
  sed -i '' "s/ARG DISTRO=$current_distro/ARG DISTRO=''/g" ./docker/Dockerfile_base
}

# Utils: 

# Version 3.0 is displayed as 3 This fixes this.
# TODO: add one for 4.0 version.
#
fix_assing_three_zero_current() {
  if [ "`echo "${current_version} == 3.0" | bc`" -eq 1 ]; then
    echo 3.0;
    else 
    echo ${VULNERUBY_RUBIES[$1]}
  fi
}

# Version 3.0 is displayed as 3 This fixes this.
# TODO: add one for 4.0 version.
#
fix_assing_three_zero_next() {
  if [ "`echo "${next_version} == 3.0" | bc`" -eq 1 ]; then
    echo 3.0;
    else 
    echo ${VULNERUBY_RUBIES[$1]}
  fi
}
