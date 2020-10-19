# frozen_string_literal: true

require 'base64'

require('vulneruby/trigger/untrusted_deserialization')

module VulnerubyEngine
  # Entry point for the Untrusted Deserialization tests
  class UntrustedDeserializationController < ApplicationController
    def index
      @example = Base64.strict_encode64(Marshal.dump('foobar'))
      render('layouts/vulneruby_engine/untrusted_deserialization/index')
    end

    def run
      @data = Base64.strict_decode64(params[:data])
      @result = Vulneruby::Trigger::UntrustedDeserialization.
          run_marshal_load(@data)
      render('layouts/vulneruby_engine/untrusted_deserialization/run')
    end
  end
end
