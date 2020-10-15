# frozen_string_literal: true

class ApplicationRecord < ::ActiveRecord::Base # rubocop:disable Lint/ConstantResolution
  self.abstract_class = true
end
