# frozen_string_literal: true

require('vulneruby/trigger/path_traversal')

module VulnerubyEngine
  # Entry point for the CMD Injection tests
  class PathTraversalController < ApplicationController
    def index
      render('layouts/vulneruby_engine/path_traversal/index')
    end

    def run
      @result = Vulneruby::Trigger::PathTraversal.run_file_read(params[:file_path])
      render('layouts/vulneruby_engine/path_traversal/run')
    end
  end
end
