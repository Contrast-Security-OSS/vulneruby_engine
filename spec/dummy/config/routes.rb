# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'application#home' if !!ENV['PASSENGER_TEST'] # rubocop:disable Style/StringHashKeys

  mount VulnerubyEngine::Engine => '/vulneruby_engine'
end
