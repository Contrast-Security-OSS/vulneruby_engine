# frozen_string_literal: true

module VulnerubyEngine
  # Entry point for the Insecure Hash Algorithm and Random tests
  class AutoloadController < ApplicationController

    def index
      render('layouts/vulneruby_engine/autoload/index')
    end

    def run
      @result = Rails.application.config.autoload.result
      render('layouts/vulneruby_engine/autoload/run')
    end
  end
end
