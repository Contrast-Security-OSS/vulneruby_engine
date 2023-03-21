# frozen_string_literal: true


class ApplicationController < ActionController::Base
  def home
    # Debride need this to be used:
    VulnerubyEngine::VERSION
    render('layouts/home')
  end
end
