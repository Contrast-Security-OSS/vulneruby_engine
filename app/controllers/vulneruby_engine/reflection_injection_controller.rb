# frozen_string_literal: true

require('vulneruby/trigger/reflection_injection')

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Entry point for the Reflection Injection tests
  class ReflectionInjectionController < ApplicationController # rubocop:disable Lint/ConstantResolution
    def index
      render('layouts/vulneruby_engine/reflection_injection/index')
    end

    def run
      @result = ::Vulneruby::Trigger::ReflectionInjection.
          run_const_get(params[:const])
      render('layouts/vulneruby_engine/reflection_injection/run')
    end
  end
end
