# frozen_string_literal: true

module VulnerubyEngine
  # Our base controller for the vulnerable application. We'll modify common
  # settings here to add new response vulnerabilities as we begin to test them.
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token

    def home
      render('layouts/vulneruby_engine/home')
    end
  end
end
