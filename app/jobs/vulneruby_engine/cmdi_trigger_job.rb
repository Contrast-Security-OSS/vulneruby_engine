# frozen_string_literal: true

require 'sidekiq-status'
require('vulneruby/trigger/cmd_injection')

module VulnerubyEngine
  class CmdiTriggerJob < ApplicationJob
    include Sidekiq::Status::Worker

    self.queue_adapter = :sidekiq
    queue_as :default

    def perform(cmdi_param)
      result = Vulneruby::Trigger::CmdInjection.run_system(cmdi_param)
      store result_data: result
      result
    end
  end
end
