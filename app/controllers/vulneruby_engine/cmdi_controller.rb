# frozen_string_literal: true

require('vulneruby/trigger/cmd_injection')

module VulnerubyEngine
  # Entry point for the Command Injection tests
  class CmdiController < ApplicationController
    def index
      render('layouts/vulneruby_engine/cmdi/index')
    end

    def run
      @result = Vulneruby::Trigger::CmdInjection.run_system(params[:command])
      render('layouts/vulneruby_engine/cmdi/run')
    end
  end
end
