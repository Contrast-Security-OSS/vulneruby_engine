# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'application#home' if !!ENV['PASSENGER_TEST'] # rubocop:disable Style/StringHashKeys
  get '/libs/:lib' => 'library_info#info'

  mount VulnerubyEngine::Engine => '/vulneruby_engine'
end
