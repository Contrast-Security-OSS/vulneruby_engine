# frozen_string_literal: true

require('vulneruby/trigger/untrusted_deserialization')

module VulnerubyEngine
  # Entry point for the CMD Injection tests
  class UntrustedDeserializationController < ApplicationController
    def index
      @example = "'#{ Marshal.dump('foobar') }'"
      render('layouts/vulneruby_engine/untrusted_deserialization/index')
    end

    def run
      @data = params[:data]
      @result = Vulneruby::Trigger::UntrustedDeserialization.
          run_marshal_load(@data)
      render('layouts/vulneruby_engine/untrusted_deserialization/run')
    end
  end
end
