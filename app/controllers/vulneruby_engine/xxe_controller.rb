# frozen_string_literal: true

require('vulneruby/trigger/xxe')

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Entry point for the XXE tests
  class XxeController < ApplicationController # rubocop:disable Lint/ConstantResolution
    def index
      render('layouts/vulneruby_engine/xxe/index')
    end

    def run
      @result = ::Vulneruby::Trigger::Xxe.run_nokogiri(params[:entity])
      render('layouts/vulneruby_engine/xxe/run')
    end
  end
end
