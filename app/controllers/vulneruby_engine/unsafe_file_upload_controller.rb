# frozen_string_literal: true

module VulnerubyEngine
  # Entry point for the Unsafe File Upload tests
  class UnsafeFileUploadController < ApplicationController
    def index
      render('layouts/vulneruby_engine/unsafe_file_upload/index')
    end

    def run
      @data = params['data']
      render('layouts/vulneruby_engine/unsafe_file_upload/run')
    end
  end
end
