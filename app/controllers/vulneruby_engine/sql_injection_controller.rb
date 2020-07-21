# frozen_string_literal: true

module VulnerubyEngine
  # Entry point for the CMD Injection tests
  class SqlInjectionController < ApplicationController
    def index
      render('layouts/vulneruby_engine/sql_injection/index')
    end

    def run
      @result = Secret.where("id = #{params[:id]}").to_a
      render('layouts/vulneruby_engine/sql_injection/run')
    end
  end
end
