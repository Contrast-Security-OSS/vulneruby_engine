# frozen_string_literal: true

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Entry point for the Reflected Cross Site Scripting tests
  class ReflectedXssController < ApplicationController # rubocop:disable Lint/ConstantResolution
    def index
      render('layouts/vulneruby_engine/reflected_xss/index')
    end

    def run
      @result = params[:data]
      render('layouts/vulneruby_engine/reflected_xss/run')
    end
  end
end
