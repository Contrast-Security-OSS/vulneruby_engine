# frozen_string_literal: true

require('vulneruby/trigger/regex_dos')

module VulnerubyEngine
  # Entry point for the Regex Denial of Service tests
  class RegexDosController < ApplicationController
    def index
      render('layouts/vulneruby_engine/regex_dos/index')
    end

    def run
      @result = Vulneruby::Trigger::RegexDos.run_regex_match(params[:data])
      render('layouts/vulneruby_engine/regex_dos/run')
    end
  end
end
