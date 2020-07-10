# frozen_string_literal: true

require('vulneruby/trigger/unsafe_code_execution')

module VulnerubyEngine
  # Entry point for the CMD Injection tests
  class UnsafeCodeExecutionController < ApplicationController
    def index
      render('layouts/vulneruby_engine/unsafe_code_execution/index')
    end

    def run
      @data = params[:data]
      @result = Vulneruby::Trigger::UnsafeCodeExecution.run_kernel_eval(@data)
      render('layouts/vulneruby_engine/unsafe_code_execution/run')
    end
  end
end
