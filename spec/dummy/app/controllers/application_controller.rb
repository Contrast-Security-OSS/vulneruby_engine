# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home
    render('layouts/home')
  end
end
