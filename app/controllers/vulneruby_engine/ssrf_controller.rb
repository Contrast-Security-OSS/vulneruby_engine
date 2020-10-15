# frozen_string_literal: true

require('vulneruby/trigger/ssrf')

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Entry point for the Server Side Request Forgery tests
  class SsrfController < ApplicationController # rubocop:disable Lint/ConstantResolution
    def index
      render('layouts/vulneruby_engine/ssrf/index')
    end

    def run
      @uri = params[:uri]
      @result = ::Vulneruby::Trigger::Ssrf.run_net_get(@uri)
      render('layouts/vulneruby_engine/ssrf/run')
    end
  end
end
