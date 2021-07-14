# frozen_string_literal: true

require 'grape'

module VulnerubyEngine
  # Base controller for the Grape framework mount
  class GrapeController < Grape::API
    format :json
  
    get :reflected_xss do
      { :attack => 'Reflected XSS'}
    end

    post :reflected_xss do
      @result = params[:data]
      { result: @result }
    end
  end
end
