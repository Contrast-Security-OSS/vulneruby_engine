#!/usr/bin/env bash

# Configuration is read and parsed to bash variables.
# Config must be available for all scripts file.

CONFIG="scripts/config.json"
VULNERUBY_DISTROS=''
VULNERUBY_RUBIES=''
PATH_DOCKERFILE_BASE=''
TARGET=''

read_config() {
 # Read Dockerfile_base path:
 PATH_DOCKERFILE_BASE=$(jq -r -e '.dockerfile_base' $CONFIG)

 # Read push target
 TARGET=$(jq -r -e '.target' $CONFIG)

 # Read distros.
 distros=$(jq -r -e '.distros' $CONFIG)
 # Convert to bash array
 to_bash_array "$distros"
 VULNERUBY_DISTROS=($ARRAY_OUTPUT)

 # Read Ruby versions.
 ruby_versions=$(jq -r -e '.ruby_versions' $CONFIG)
 to_bash_array "$ruby_versions"
 VULNERUBY_RUBIES=($ARRAY_OUTPUT)
}

# Takes as parameter the parsed jq array:
to_bash_array() {
  local array=$1
  local output=$(echo $array | sed -e 's/\[ //g' -e 's/\ ]//g' -e 's/\,//g')
  ARRAY_OUTPUT="$output"
}

# Invoke Config parsing.
read_config
