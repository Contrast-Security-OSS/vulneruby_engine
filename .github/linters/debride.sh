#!/usr/bin/env bash

OUT_FILE="debride_out.txt"

bundle config set path 'vendor/bundle'
bundle install

# Exclude the API classes b/c we'll never call all of them / debride has issues tracking
bundle exec debride --whitelist ./.github/linters/debride_allowlist.txt -e ./lib/contrast/api/settings_pb.rb,./lib/contrast/api/dtm_pb.rb ./lib > $OUT_FILE

OUTPUT=$(cat $OUT_FILE)

# look for new output suggesting no violations are found: 
MATCH=$(expr "$OUTPUT" : '\(.*Total suspect LOC: 0\)')

if [ -z "$MATCH" ]; then
  # If the match is empty we have dead code
  echo "Dead code was found. See $OUT_FILE for details:"
  cat $OUT_FILE
  exit 1
else
  echo "No dead code found"
fi
