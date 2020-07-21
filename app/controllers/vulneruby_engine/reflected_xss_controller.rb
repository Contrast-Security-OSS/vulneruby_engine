# frozen_string_literal: true

module VulnerubyEngine
  # Entry point for the CMD Injection tests
  class ReflectedXssController < ApplicationController
    def index
      render('layouts/vulneruby_engine/reflected_xss/index')
    end

    def run
      @result = params[:data].html_safe
      render('layouts/vulneruby_engine/reflected_xss/run')
    end
  end
end
