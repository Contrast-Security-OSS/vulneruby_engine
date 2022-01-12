# frozen_string_literal: true

module VulnerubyEngine
  class ApplicationJob < ActiveJob::Base
    include Sidekiq::Status::Worker
  end
end
