# frozen_string_literal: true

require_relative('boot')

require('rails/all')
require('sprockets/railtie')
require 'mongoid'

Bundler.require(*Rails.groups)
Bundler.require(:passenger_max) if !!ENV['PASSENGER_MAX']
Bundler.require(:passenger_min) if !!ENV['PASSENGER_MIN']
Bundler.require(:puma_max) if !!ENV['PUMA_MAX']
Bundler.require(:puma_min) if !!ENV['PUMA_MIN']
Bundler.require(:thin_max) if !!ENV['THIN_MAX']
Bundler.require(:thin_min) if !!ENV['THIN_MIN']
Bundler.require(:unicorn_min) if !!ENV['UNICORN_MIN']
Bundler.require(:unicorn_max) if !!ENV['UNICORN_MAX']
Bundler.require(:mongoid)

require('vulneruby_engine')

require('warning')
Warning.ignore(/Using the last argument as keyword parameters is deprecated/)


module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults(7.0)
    log_path = ENV['APP_LOG'] || "log/#{ Rails.env }.log"
    config.logger = ActiveSupport::Logger.new(log_path)

    config.mongoid.logger = Logger.new($stdout)
    # Settings in config/environments/* take precedence over those specified
    # here. Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
