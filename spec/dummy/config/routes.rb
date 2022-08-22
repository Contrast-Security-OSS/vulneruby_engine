# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'application#home' if !!ENV['PASSENGER_MAX'] || !!ENV['PASSENGER_MIN']
  get '/libs/:lib' => 'library_info#info'

  mount VulnerubyEngine::Engine => '/vulneruby_engine'
end
