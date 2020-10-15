# frozen_string_literal: true

require('vulneruby/trigger/path_traversal')

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Entry point for the Path Traversal tests
  class PathTraversalController < ApplicationController # rubocop:disable Lint/ConstantResolution
    def index
      render('layouts/vulneruby_engine/path_traversal/index')
    end

    def run
      @result = ::Vulneruby::Trigger::PathTraversal.
          run_file_read(params[:file_path])
      render('layouts/vulneruby_engine/path_traversal/run')
    end
  end
end
