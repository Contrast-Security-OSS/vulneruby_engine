# frozen_string_literal: true

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Our rails engine for the vulnerable application
  class Engine < ::Rails::Engine # rubocop:disable Lint/ConstantResolution
    isolate_namespace ::VulnerubyEngine
    engine_name 'vulneruby_engine'

    config.generators do |g|
      g.test_framework(:rspec)
    end
  end
end
