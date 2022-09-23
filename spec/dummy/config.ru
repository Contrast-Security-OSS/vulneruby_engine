# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative('config/environment')
require 'mongoid'

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))
use Rack::Session::Cookie
run(Rails.application)
