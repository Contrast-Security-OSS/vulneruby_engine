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

    get '/sql_injection' do
      @page = erb(:'sql_injection/index.html')
      erb :'application.html'
    end

    post '/sql_injection' do
      @result = params[:data].html_safe
      @page = erb(:'sql_injection/run.html')
      erb :'application.html'
    end

    post '/unvalidated_redirect' do
      redirect params[:url]
    end

    post '/ssrf' do
      uri = CGI.unescape(params[:uri].split('=').last)
      Net::HTTP.get(URI(uri))
    end

    get '/unset_rack_session' do
      Rack::Session::Cookie.new(
        {},
        {
            key: 'rack.session',
            httponly: true,
            secret: 'very_secret_secret',
            old_secret: 'some_old_secret',
            secure: true
        })
      'Expire time is unset'
    end

    get '/secure_flag' do
      Rack::Session::Cookie.new(
        {},
        {
            key: 'rack.session',
            httponly: true,
            expire_after: 100,
            secret: 'secret_new',
            old_secret: 'old_secret'
        })
    'secure-flag'
    end

    get '/httponly_flag' do
      Rack::Session::Cookie.new(
        {},
        {
            key: 'rack.session',
            httponly: false,
            expire_after: 100,
            secret: 'secret_new',
            old_secret: 'old_secret',
            secure: true
        })
      'httponly-flag'
    end

    use Rack::Session::Cookie,
        key: 'rack.session',
        domain: 'foo.com',
        path: '/',
        expire_after: 2_592_000,
        secret: 'change_me'

    post '/trust_boundary' do
      env['rack.session'][:HTTP_USER_AGENT] = params["HTTP_USER_AGENT"]
      env["rack.session"]
    end

    post '/cmdi' do
      Kernel.`(params['cmd'])
    end
  end
end