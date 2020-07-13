# frozen_string_literal: true

require('vulneruby/trigger/cmd_injection')

module VulnerubyEngine
  # Entry point for the CMD Injection tests
  class CmdiController < ApplicationController
    def index
      render('layouts/vulneruby_engine/header_misconfiguration/index')
    end

    def run
      #This should involve
      # DONE cache-controls-missing
      # DONE xcontent-typeheader-missing
      # session-timeout,
      # rails-http-only-disabled,
      # csp-header-insecure,
      # hsts-header-missing,
      # xxss-protection-header-disabled,
      # csp-header-missing,
      # secure-flag-missing
      response.delete_header('Cache-Control')
      response.delete_header('X-Frame-Options')
      response.delete_header('X-Content-Type-Options')
      response.delete_header('Strict-Transport-Security')
      render('layouts/vulneruby_engine/header_misconfiguration/run')
    end
  end
end
