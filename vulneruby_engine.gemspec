$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "vulneruby_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "vulneruby_engine"
  spec.version     = VulnerubyEngine::VERSION
  spec.authors     = ["Donald Propst"]
  spec.email       = ["donald.propst@contrastsecurity.com"]
  spec.homepage    = "https://github.com"
  spec.summary     = "Summary of VulnerubyEngine."
  spec.description = "Description of VulnerubyEngine."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.1"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rails-controller-testing"

  spec.add_development_dependency "sqlite3"
end
