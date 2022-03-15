# frozen_string_literal: true

module VulnerubyEngine
  # Entry point for the Insecure Hash Algorithm and Random tests
  autoload(:Autoload, './app/models/vulneruby_engine/autoload.rb')
  class AutoloadController < ApplicationController
    def index
      render('layouts/vulneruby_engine/autoload/index')
    end

    def run
      @result = Autoload::RESULT
      render('layouts/vulneruby_engine/autoload/run')
    end
  end
end
