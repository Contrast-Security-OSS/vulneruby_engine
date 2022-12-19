# frozen_string_literal: true

require 'sinatra'
require 'fileutils'
require 'vulneruby/trigger/path_traversal'

module VulnerubyEngine
  # Base controller for the Sinatra mount, used to test XSS and other framework
  # specific vulnerabilities
  class SinatraController < ::Sinatra::Base
    include FileUtils::Verbose
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
      @result = params[:data]
      res = Rack::Response.new('', 200, {})
      res.body = @result
      @page = erb(:'reflected_xss/run.html')
      erb :'application.html'
    end

    get '/sql_injection' do
      @page = erb(:'sql_injection/index.html')
      erb :'application.html'
    end

    post '/sql_injection' do
      @result = params[:data]
      res = Rack::Response.new('', 200, {})
      res.body = @result
      @page = erb(:'sql_injection/run.html')
      erb :'application.html'
    end

    get '/nosql_injection' do
      @page = erb(:'nosql_injection/index.html')
      erb :'application.html'
    end

    post '/nosql_injection' do
      @result = SecretMongo.where(:'id'.ne => params[:id]).to_a
      @page = erb(:'nosql_injection/run.html')
      erb :'application.html'
    end

    get '/unsafe_file_upload' do
      @page = erb(:'unsafe_file_upload/index.html')
      erb :'application.html'
    end

    post '/unsafe_file_upload' do
      tempfile = params[:data][:tempfile] 
      filename = params[:data][:filename]
      cp(tempfile.path, "./#{filename}")
      @data = File.open("./#{filename}")
      @page = erb(:'unsafe_file_upload/run.html')
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

    post '/path_traversal' do
      Vulneruby::Trigger::PathTraversal.
      run_file_read(params[:file_path])
    end

    get '/path_traversal' do
      'here to test some v2 input tracing...'
    end

    get '/autoload'do
      @result = Autoload::RESULT
    end

    post '/autoload'do
      @result = Autoload::RESULT
    end

    post '/cmdi' do
      cmd = params[:command]
      Kernel.`(cmd)
    end
  end
end