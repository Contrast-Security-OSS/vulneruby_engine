# frozen_string_literal: true

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Our base controller for the vulnerable application. We'll modify common
  # settings here to add new response vulnerabilities as we begin to test them.
  class ApplicationController < ActionController::Base # rubocop:disable Lint/ConstantResolution
    protect_from_forgery with: :exception

    def home
      render('layouts/vulneruby_engine/home')
    end
  end
end
