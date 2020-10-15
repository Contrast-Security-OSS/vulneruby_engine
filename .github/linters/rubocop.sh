#!/usr/bin/env bash

bundle config set path 'vendor/bundle'
bundle install
bundle exec rubocop