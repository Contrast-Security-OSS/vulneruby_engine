# frozen_string_literal: true

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Entry point for the SQL Injection tests
  class SqlInjectionController < ApplicationController  # rubocop:disable Lint/ConstantResolution
    def index
      render('layouts/vulneruby_engine/sql_injection/index')
    end

    def run
      @result = ::VulnerubyEngine::Secret.where("id = #{ params[:id] }").to_a
      render('layouts/vulneruby_engine/sql_injection/run')
    end
  end
end
