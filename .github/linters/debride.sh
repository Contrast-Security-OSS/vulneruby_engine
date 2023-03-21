#!/usr/bin/env bash

OUT_FILE="debride_out.txt"
EXPECTED_OUTPUT_FILE="debride_no_suspects.txt"

bundle config set path 'vendor/bundle'
bundle install

# Exclude the API classes b/c we'll never call all of them / debride has issues tracking
bundle exec debride --whitelist ./.github/linters/debride_allowlist.txt -e ./lib/contrast/api/settings_pb.rb,./lib/contrast/api/dtm_pb.rb ./lib > $OUT_FILE

# inspect differences: 
DIFF=$(diff -a --suppress-common-lines -y $OUT_FILE $EXPECTED_OUTPUT_FILE)
LENGTH=${#DIFF}

if [ $LENGTH == 0 ]; then
  echo "No dead code found"
  echo $LENGTH
else
  echo "Dead code was found. See $OUT_FILE for details:"
  cat $OUT_FILE
  exit 1
fi
