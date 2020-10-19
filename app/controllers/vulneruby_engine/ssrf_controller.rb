# frozen_string_literal: true

require('vulneruby/trigger/ssrf')

module VulnerubyEngine
  # Entry point for the Server Side Request Forgery tests
  class SsrfController < ApplicationController
    def index
      render('layouts/vulneruby_engine/ssrf/index')
    end

    def run
      @uri = params[:uri]
      @result = Vulneruby::Trigger::Ssrf.run_net_get(@uri)
      render('layouts/vulneruby_engine/ssrf/run')
    end
  end
end
