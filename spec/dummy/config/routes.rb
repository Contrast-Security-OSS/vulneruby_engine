# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'application#home'

  mount VulnerubyEngine::Engine => '/vulneruby_engine'
end
