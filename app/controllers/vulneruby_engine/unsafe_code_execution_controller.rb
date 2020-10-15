# frozen_string_literal: true

require('vulneruby/trigger/unsafe_code_execution')

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Entry point for the Unsafe Code Execution tests
  class UnsafeCodeExecutionController < ApplicationController # rubocop:disable Lint/ConstantResolution
    def index
      render('layouts/vulneruby_engine/unsafe_code_execution/index')
    end

    def run
      @data = params[:data]
      @result = ::Vulneruby::Trigger::UnsafeCodeExecution.run_kernel_eval(@data)
      render('layouts/vulneruby_engine/unsafe_code_execution/run')
    end
  end
end
