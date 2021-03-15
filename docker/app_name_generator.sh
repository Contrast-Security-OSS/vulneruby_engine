#!/usr/bin/env bash
RUBYVER=$(ruby --version | awk '{print $2}')
echo "RailsEngine-$RUBYVER-$1-$(date +%s)"
