# frozen_string_literal: true

source('https://rubygems.org')
git_source(:github) { |repo| "https://github.com/#{ repo }.git" }

# Declare your gem's dependencies in vulneruby_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Pull in our vulnerable gem used to call the triggers
gem(
    'vulneruby',
    git: 'https://github.com/Contrast-Security-OSS/vulneruby')

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]
gem 'contrast-agent'