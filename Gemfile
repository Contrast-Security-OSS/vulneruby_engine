# frozen_string_literal: true

source('https://rubygems.org')
git_source(:github) { |repo| "https://github.com/#{ repo }.git" }

# Declare your gem's dependencies in vulneruby_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec
gem 'sidekiq', '~> 6.3', '>= 6.3.1'
gem 'sidekiq-status', '~> 2.1'

# Pull in our vulnerable gem used to call the triggers
gem('vulneruby', git: 'https://github.com/Contrast-Security-OSS/vulneruby')

group 'passenger_max', optional: true do
  if !!ENV['PASSENGER_MAX']
    gem 'passenger', '~> 6.0', require: 'phusion_passenger/rack_handler'
    gem 'tzinfo-data'
  end
end

group 'passenger_min', optional: true do
  if !!ENV['PASSENGER_MIN']
    gem 'passenger', '5.3.7', require: 'phusion_passenger/rack_handler'
  end
end

group 'puma_min', optional: true do
  gem 'puma', '~> 3.7' if !!ENV['PUMA_MIN']
end

group 'puma_max', optional: true do
  gem 'puma', '~> 5.0' if !!ENV['PUMA_MAX']
end

group 'thin_min', optional: true do
  gem 'thin', '1.7.2' if !!ENV['THIN_MIN']
end

group 'thin_max', optional: true do
  gem 'thin', '~> 1.0' if !!ENV['THIN_MAX']
end

group 'unicorn_min', optional: true do
  if !!ENV['UNICORN_MIN']
    if RUBY_VERSION >= '3.0.0'
      gem 'unicorn', '~> 5.7.0'
    else
      gem 'unicorn', '~> 5.0.0'
    end
  end
end

group 'unicorn_max', optional: true do
  gem 'unicorn', '~> 6' if !!ENV['UNICORN_MAX']
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
