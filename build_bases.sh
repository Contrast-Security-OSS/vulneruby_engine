#!/bin/bash

set -Eeuo pipefail

SCRIPTNAME=$(basename "${BASH_SOURCE[0]}")
APP_ROOT=$(dirname "${BASH_SOURCE[0]}")
GIT_REPO=contrast-security-oss/vulneruby_engine

RUBY_VERS="2.5 2.6 2.7 3.0"


usage() {
  cat <<EOF
Usa ge: $SCRIPTNAME [-h] [options]

    Build and upload base images for supported Ruby versions: $RUBY_VERS

    Sign in to these first.

Available options:

    -h,    --help           Print this help and exit
EOF
  exit
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  echo "$msg"
  exit "$code"
}

parse_params() {
    # Actual parsing.
    while :; do
      case "${1-}" in
      -h | --help) usage ;;
      -?*) die "Unknown option: $1" ;;
      *) break ;;
      esac
      shift
    done
    args=("$@")

    return 0
}

parse_params "$@"

for ver in $RUBY_VERS; do
    TAG=ghcr.io/$GIT_REPO/base:$ver
    docker build --tag $TAG --build-arg RUBY_VER=$ver -f $APP_ROOT/docker/Dockerfile_base $APP_ROOT
    docker push $TAG
done
