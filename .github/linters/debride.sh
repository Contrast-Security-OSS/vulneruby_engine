#!/usr/bin/env bash

OUT_FILE="debride_out.txt"

bundle config set path 'vendor/bundle'
bundle install

# Exclude the API classes b/c we'll never call all of them / debride has issues tracking
bundle exec debride --whitelist ./.github/linters/debride_allowlist.txt -e ./lib/contrast/api/settings_pb.rb,./lib/contrast/api/dtm_pb.rb ./lib > $OUT_FILE

# "These methods MIGHT not be called:\n" is always output
COUNT=$(wc -l < $OUT_FILE)
if [ $COUNT == 1 ]; then
  echo "No dead code found"
else
  echo "Dead code was found. See $OUT_FILE for details"
  exit 1
fi
