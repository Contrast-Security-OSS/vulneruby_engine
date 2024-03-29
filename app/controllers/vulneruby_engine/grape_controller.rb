# frozen_string_literal: true

require 'grape'
require 'fileutils'
require 'vulneruby/trigger/path_traversal'

module VulnerubyEngine
  # Base controller for the Grape framework mount
  class GrapeController < Grape::API
    include FileUtils::Verbose
    format :json

    get '/' do
      'Hello Grape!'
    end

    get '/reflected_xss' do
      { attack: 'Post data for Reflected XSS' }
    end

    post '/reflected_xss' do
      @result = params[:data]
      res = Rack::Response.new('', 200, {})
      res.body = @result
      { result: @result }
    end


    get '/stored_xss' do
      { attack: 'Post message for Stored XSS' }
    end

    post '/stored_xss' do
      @user = VulnerubyEngine::User.create(name: 'Grape_Kaizen')
      @user.save!
      # Handle comments:
      new_comment = VulnerubyEngine::Comment.create(user_id: @user.id, message: params[:message])
      new_comment.save!
      @result = @user.comments[0].message
      res = Rack::Response.new('', 200, {})
      res.body = @result
      { result: @result }
    end

    post '/unvalidated_redirect' do
      redirect params[:url]
    end

    get '/sql_injection' do
      'sql injection page'
    end

    post '/sql_injection' do
      @result = params[:id]
      res = Rack::Response.new('', 200, {})
      res.body = @result
      { result: @result }
    end

    get '/sql_injection_exclusion' do
      'sql injection page'
    end

    post '/sql_injection_exclusion' do
      @result = params[:id]
      res = Rack::Response.new('', 200, {})
      res.body = @result
      { result: @result }
    end

    post '/ssrf' do
      uri = CGI.unescape(params[:uri].split('=').last)
      Net::HTTP.get(URI(uri))
    end

    get '/unsafe_file_upload' do
      { attack: 'Unsafe File Upload' }
    end

    post '/unsafe_file_upload' do
      tempfile = params[:data][:tempfile]
      filename = params[:data][:filename]
      FileUtils.cp(tempfile.path, "./#{filename}")
      @data = File.open("./#{filename}")
      { "result": @data.read }  
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

    get '/sql_injection' do
      { attack: 'SQL Injection' }
    end

    post '/sql_injection' do
      @result = params[:id].html_safe
      { result: @result }
    end

    get '/nosql_injection' do
      { attack: 'NoSQL Injection' }
    end

    post '/nosql_injection' do
      @result = SecretMongo.where(:'id'.ne => params[:name]).to_a
      { result: @result }
    end

    use Rack::Session::Cookie,
        key: 'rack.session',
        domain: 'foo.com',
        path: '/',
        expire_after: 2_592_000,
        secret: 'change_me'

    post '/trust_boundary' do
      env['rack.session'][:HTTP_USER_AGENT] = params[:HTTP_USER_AGENT]
      env['rack.session'].to_s
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
      @result.to_s
    end

    post '/autoload'do
      @result = Autoload::RESULT
      @result.to_s
    end

    post '/cmdi' do
      @cmd = params[:command]
      Kernel.` @cmd
    end
  end
end
