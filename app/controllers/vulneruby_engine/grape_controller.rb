# frozen_string_literal: true

require 'grape'

module VulnerubyEngine
  # Base controller for the Grape framework mount
  class GrapeController < Grape::API
    format :json

    get '/' do
      'Hello Grape!'
    end

    get '/reflected_xss' do
      { attack: 'Reflected XSS' }
    end

    post '/reflected_xss' do
     @result = params[:data].html_safe
     header 'Content-Type', 'text/html'
     { result: @result }
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

    post '/cmdi' do
      Kernel.`(params['cmd'])
    end

    use Rack::Session::Cookie,
        key: 'rack.session',
        domain: 'foo.com',
        path: '/',
        expire_after: 2_592_000,
        secret: 'change_me'

    post '/trust_boundary' do
      env['rack.session'][:HTTP_USER_AGENT] = params[:HTTP_USER_AGENT]
      env['rack.session']
    end
  end
end
