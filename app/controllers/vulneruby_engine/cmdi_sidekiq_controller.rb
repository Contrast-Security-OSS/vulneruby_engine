# frozen_string_literal: true

# require 'sidekiq-status'
require('vulneruby/trigger/cmd_injection')

module VulnerubyEngine
  # Entry point for the Command Injection tests through job
  class CmdiSidekiqController < ApplicationController

    def index
      render('layouts/vulneruby_engine/cmdi_sidekiq/index')
    end

    def run
      @result = CmdiTriggerJob.perform_now(params[:command])
      render_result
    end

    private

    def render_result
      render('layouts/vulneruby_engine/cmdi_sidekiq/run')
    end
  end
end
