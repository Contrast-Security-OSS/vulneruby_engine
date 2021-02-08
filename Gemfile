# frozen_string_literal: true

source('https://rubygems.org')
git_source(:github) { |repo| "https://github.com/#{ repo }.git" }

# Declare your gem's dependencies in vulneruby_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Pull in our vulnerable gem used to call the triggers
gem('vulneruby', git: 'https://github.com/Contrast-Security-OSS/vulneruby')

group 'passenger', optional: true do
  if !!ENV['PASSENGER']
    gem 'passenger', '~> 6.0', require: 'phusion_passenger/rack_handler'
    gem 'tzinfo-data'
  end
end

group 'puma', optional: true do
  gem 'puma', '~> 3.0' if !!ENV['PUMA']
end

group 'thin', optional: true do
  gem 'thin', '~> 1.0' if !!ENV['THIN']
end

group 'unicorn_4', optional: true do
  gem 'unicorn', '~> 4' if !!ENV['UNICORN_4']
end

group 'unicorn_5', optional: true do
  gem 'unicorn', '~> 5' if !!ENV['UNICORN_5']
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]gem 'contrast-agent', path: './agent'
#
# agent_path here is used to tell bundler to use a local gem path pointed to by gem which contrast-agent.
if (agent_path=ENV['AGENT_PATH'])
  agent_path = agent_path.gsub('/lib/contrast-agent.rb', '')
  gem 'contrast-agent', path: agent_path if !!ENV['CI_TEST']
else
   gem 'contrast-agent' if !!ENV['CI_TEST']
end
