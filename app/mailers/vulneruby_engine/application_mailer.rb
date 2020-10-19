# frozen_string_literal: true

module VulnerubyEngine
  # Mailer for the vulnerable application. It might actually be unused and we
  # may remove it.
  class ApplicationMailer < ActionMailer::Base
    default from: 'from@example.com'
    layout 'mailer'
  end
end
