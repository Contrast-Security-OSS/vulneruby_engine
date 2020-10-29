# frozen_string_literal: true

require_relative('boot')

require('rails/all')

Bundler.require(*Rails.groups)
Bundler.require(:passenger) if !!ENV['PASSENGER_TEST']
Bundler.require(:puma) if !!ENV['PUMA_TEST']
Bundler.require(:thin) if !!ENV['THIN_TEST']
Bundler.require(:unicorn_4) if !!ENV['UNICORN_4_TEST']
Bundler.require(:unicorn_5) if !!ENV['UNICORN_5_TEST']

require('vulneruby_engine')

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults(6.0)

    # Settings in config/environments/* take precedence over those specified
    # here. Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
