#!/usr/bin/env bash

OUT_FILE="flay_out.txt"

bundle config set path 'vendor/bundle'
bundle update

expected_string="Total score (lower is better) = 0"
bundle exec flay ./lib > $OUT_FILE

if [[ $(cat $OUT_FILE) != $expected_string ]]; then
  echo "Failure"
  cat $OUT_FILE
  exit 1
else
  echo "Success"
  cat $OUT_FILE
  exit 0
fi
