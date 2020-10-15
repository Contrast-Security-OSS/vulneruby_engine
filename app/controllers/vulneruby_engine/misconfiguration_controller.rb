# frozen_string_literal: true

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Entry point for the misconfiguration and response based tests
  class MisconfigurationController < ApplicationController # rubocop:disable Lint/ConstantResolution
    def index
      render('layouts/vulneruby_engine/misconfiguration/index')
    end

    def run
      response.set_header('Cache-Control', 'no-cache, store')
      response.set_header('Pragma', 'no-cache')
      response.set_header('Expires', 'Fri, 01 Jan 1990 00:00:00 GMT')
      response.set_header('X-XSS-Protection', '0')
      response.set_header('X-Frame-Options', 'InvalidValue')
      response.set_header('X-Content-Type-Options', 'InvalidValue')
      response.set_header('X-Content-Security-Policy', 'default-src= none; object-src foo')
      response.delete_header('Strict-Transport-Security')
      @result = response.headers
      render('layouts/vulneruby_engine/misconfiguration/run')
    end
  end
end
