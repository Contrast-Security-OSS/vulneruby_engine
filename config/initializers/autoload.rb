require 'vulneruby_engine/autoload'

#Put model in config to be autoloaded
Rails.application.config.autoload = VulnerubyEngine::Autoload.new