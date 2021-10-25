# frozen_string_literal: true

module VulnerubyEngine
  # Entry point for the Reflected Cross Site Scripting tests
  class ReflectedXssController < ApplicationController
    def index
      render('layouts/vulneruby_engine/reflected_xss/index')
    end

    def run
      response = Rack::Response.new
      response.headers['Content-Type'] = 'text/html'
      @result = params[:data]
      render('layouts/vulneruby_engine/reflected_xss/run')
    end
  end
end
