# frozen_string_literal: true

class ApplicationMailer < ::ActionMailer::Base # rubocop:disable Lint/ConstantResolution
  default from: 'from@example.com'
  layout 'mailer'
end
