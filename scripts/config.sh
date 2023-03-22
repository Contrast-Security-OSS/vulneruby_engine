#!/usr/bin/env bash

CONFIG="scripts/config.json"
VULNERUBY_DISTROS=''
VULNERUBY_RUBIES=''
ARRAY_OUTPUT=()

read_config() {
 # Read distros.
 distros=$(jq -r -e '.distros' $CONFIG)
 # Convert to bash array
 to_bash_array "$distros"
 VULNERUBY_DISTROS=($ARRAY_OUTPUT)
 echo $VULNERUBY_DISTROS

 # Read Ruby versions.
 ruby_versions=$(jq -r -e '.ruby_versions' $CONFIG)
 to_bash_array "$ruby_versions"
 VULNERUBY_RUBIES=($ARRAY_OUTPUT)
 echo $VULNERUBY_RUBIES
}

# Takes as parameter the parsed jq array:
to_bash_array() {
  local array=$1
  local output=$(echo $array | sed -e 's/\[ //g' -e 's/\ ]//g' -e 's/\,//g')
  ARRAY_OUTPUT="$output"
}

read_config