# frozen_string_literal: true

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Our base record for the vulnerable application. We'll modify common
  # settings here to add new SQL and Serialization vulnerabilities as we begin
  # to test them.
  class ApplicationRecord < ::ActiveRecord::Base # rubocop:disable Lint/ConstantResolution
    self.abstract_class = true
  end
end
