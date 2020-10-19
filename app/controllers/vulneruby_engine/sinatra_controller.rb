# frozen_string_literal: true

require 'sinatra'

module VulnerubyEngine
  # Base controller for the Sinatra mount, used to test XSS and other framework
  # specific vulnerabilities
  class SinatraController < ::Sinatra::Base
    set :views, "#{ __dir__ }/../../views/layouts/sinatra"

    get '/' do
      @page = erb(:'home.html')
      erb :'application.html'
    end

    get '/reflected_xss' do
      @page = erb(:'reflected_xss/index.html')
      erb :'application.html'
    end

    post '/reflected_xss' do
      @result = params[:data].html_safe
      @page = erb(:'reflected_xss/run.html')
      erb :'application.html'
    end
  end
end
