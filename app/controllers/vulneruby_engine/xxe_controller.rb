# frozen_string_literal: true

require('vulneruby/trigger/xxe')

module VulnerubyEngine
  # Entry point for the XML External Entity tests
  class XxeController < ApplicationController
    def index
      render('layouts/vulneruby_engine/xxe/index')
    end

    def run
      @result = Vulneruby::Trigger::Xxe.run_nokogiri(params[:entity])
      render('layouts/vulneruby_engine/xxe/run')
    end
  end
end
