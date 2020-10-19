# frozen_string_literal: true

module VulnerubyEngine
  # Our rails engine for the vulnerable application
  class Engine < ::Rails::Engine
    isolate_namespace VulnerubyEngine
    engine_name 'vulneruby_engine'

    config.generators do |g|
      g.test_framework(:rspec)
    end
  end
end
