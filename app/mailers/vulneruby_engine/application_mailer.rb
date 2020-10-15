# frozen_string_literal: true

module VulnerubyEngine # rubocop:disable Lint/ConstantResolution
  # Mailer for the vulnerable application. It might actually be unused and we
  # may remove it.
  class ApplicationMailer < ::ActionMailer::Base # rubocop:disable Lint/ConstantResolution
    default from: 'from@example.com'
    layout 'mailer'
  end
end
