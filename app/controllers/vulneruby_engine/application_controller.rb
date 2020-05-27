module VulnerubyEngine
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def home
      render 'layouts/vulneruby_engine/home'
    end
  end
end
