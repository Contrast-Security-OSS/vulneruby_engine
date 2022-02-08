# frozen_string_literal: true

$LOAD_PATH.push(::File.expand_path('lib', __dir__))

# Maintain your gem's version:
require('vulneruby_engine/version')

# Add those dependencies required to develop or test the project
def self.add_dev_dependencies spec
  spec.add_development_dependency('headless', '~> 2.3')
  spec.add_development_dependency('rails-controller-testing')
  spec.add_development_dependency('rspec', '~> 3.0')
  spec.add_development_dependency('rspec-rails')
  spec.add_development_dependency 'rspec_junit_formatter', '0.3.0'
  spec.add_development_dependency('simplecov', '~> 0.18.5')
  spec.add_development_dependency('sqlite3')
  spec.add_development_dependency('warning')
  spec.add_development_dependency('watir')
  spec.add_development_dependency('webdrivers', '~> 4.0')
end

def self.add_lint_dependencies spec
  spec.add_development_dependency('debride')
  spec.add_development_dependency('fasterer')
  spec.add_development_dependency('flay')
  spec.add_development_dependency('rubocop', '1.22.3')
  spec.add_development_dependency('rubocop-performance', '1.12.0')
  spec.add_development_dependency('rubocop-rspec', '2.6.0')
end

# Add those dependencies required to run the project
def self.add_dependencies spec
  spec.add_dependency('rails', '~> 6.0.4')
  spec.add_dependency('rake', '~> 12.3.0')
  spec.add_dependency('sinatra', '~> 2.0')
  spec.add_dependency('grape', '~> 1.5.3')
  spec.add_dependency('sidekiq', '~> 6.3', '>= 6.3.1')
  spec.add_dependency('sidekiq-status', '~> 2.1')
end

# Describe your gem and declare its dependencies:
::Gem::Specification.new do |spec|
  spec.name        = 'vulneruby_engine'
  spec.version     = ::VulnerubyEngine::VERSION
  spec.authors     = ['Donald Propst']
  spec.email       = ['donald.propst@contrastsecurity.com']
  spec.homepage    = 'https://github.com'
  spec.summary     = 'Summary of VulnerubyEngine.'
  spec.description = 'Description of VulnerubyEngine.'
  spec.license     = 'MIT'
  spec.required_ruby_version = '>= 2.5.0'
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host' to allow pushing to a single host or delete this
  # section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://mygemserver.com'
  else
    raise(
        ::StandardError,
        'RubyGems 2.0 or newer is required to protect against public gem '\
        'pushes.')
  end

  spec.files = ::Dir[
      '{app,config,db,lib}/**/*',
      'MIT-LICENSE',
      'Rakefile',
      'README.md'
  ]

  add_dev_dependencies(spec)
  add_lint_dependencies(spec)
  add_dependencies(spec)
end
