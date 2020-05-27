module VulnerubyEngine
  class Engine < ::Rails::Engine
    isolate_namespace VulnerubyEngine
    engine_name 'vulneruby_engine'

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
