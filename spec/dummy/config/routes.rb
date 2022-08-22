# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'
  get '/libs/:lib' => 'library_info#info'

  mount VulnerubyEngine::Engine => '/vulneruby_engine'
end
