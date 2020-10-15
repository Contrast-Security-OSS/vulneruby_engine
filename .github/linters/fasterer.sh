#!/usr/bin/env bash

OUT_FILE="fasterer_out.txt"

bundle config set path 'vendor/bundle'
bundle install
bundle exec fasterer > $OUT_FILE
COUNT=$(wc -l < $OUT_FILE)
if [ $COUNT == 1 ]; then
  echo "No slow code found"
else
  echo "Slow code was found. See $OUT_FILE for details"
  exit 1
fi
